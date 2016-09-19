//
//  HomeView.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    var items: [Item] = []
    let imageCache = NSCache()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        self.searchBar.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Empty local image cache as they can be re-downloaded
        self.imageCache.removeAllObjects()
    }
    //delegate searchBar
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        self.items.removeAll()
        AlamofireRequest.sharedInstance.getLatLng(searchBar.text!) { (location: JSON) -> Void in
            for a in location.arrayValue
            {
                let tempLocation = a["geometry"]["location"]
                AlamofireRequest.sharedInstance.getInformationOfItemVia(tempLocation["lat"].rawString()! , longitude:tempLocation["lng"].rawString()!) { (jsonDic:JSON!) -> Void in
                    for a in jsonDic.arrayValue
                    {
                        self.items.append(Item(website: a["provider"]["url"].rawString()!, latLng: a["latLng"].arrayObject as! [Double], price: a["price"]["nightly"].rawString()!, location: a["location"]["all"].rawString()!, reviews: a["reviews"]["rating"].rawString()!, photos: a["photos"].arrayObject!, attr: a["attr"].dictionaryObject!))
                        self.myCollectionView.reloadData()
                    }
                }
            }
        }
    }
    //delegate collectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ItemCell
        cell.addSubviews(true)
        let imageURL = items[indexPath.item].photos[0]["large"] as! String
        cell.price.text = items[indexPath.item].price! + "$"
        cell.nameLabel.text = items[indexPath.item].attr["heading"] as? String
        cell.isCalAvailable = (items[indexPath.item].attr["isCalAvailable"] as? Bool)!
        if let image = self.imageCache.objectForKey(imageURL) as? UIImage { // Use the local cache if possible
            cell.imageView.image = image
        } else { // Download from the internet
            AlamofireRequest.sharedInstance.getImage(imageURL) { (data: NSData!) -> Void in
                if let image = UIImage(data: data)
                {
                    self.imageCache.setObject(image, forKey: imageURL)
                    cell.imageView.image = image
                    self.items[indexPath.item].imgProfile = image
                }
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailItem") as? DetailItem
        detailView?.item = items[indexPath.item]
        self.navigationController!.pushViewController(detailView!, animated: true)
        
    }
}
