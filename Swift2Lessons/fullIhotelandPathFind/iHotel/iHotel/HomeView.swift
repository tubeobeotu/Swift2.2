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
import FBSDKShareKit
class HomeView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var activityLoad: UIActivityIndicatorView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    var img : UIImage?
    var profileName : String!
    var items: [Item] = []
    let imageCache = NSCache()
    var updatedSize: CGSize!
    override func viewDidLoad() {
        super.viewDidLoad()
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "user"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: "OpenViewLogin", forControlEvents: .TouchUpInside)
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        self.searchBar.delegate = self
        activityLoad.hidden = true
        self.searchBar.setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Empty local image cache as they can be re-downloaded
        self.imageCache.removeAllObjects()
    }
    func activeLoad()
    {
        if (activityLoad.isAnimating())
        {
            activityLoad.hidden = true
            activityLoad.stopAnimating()
        }
        else
        {
            activityLoad.hidden = false
            activityLoad.startAnimating()
        }
    }
    //search current
    func searchPlace(lat: String, lng: String)
    {
        if (activityLoad.isAnimating())
        {
            return
        }
        self.activeLoad()
        self.items.removeAll()
        self.imageCache.removeAllObjects()
        self.myCollectionView.reloadData()
        AlamofireRequest.sharedInstance.getInformationOfItemVia(lat , longitude:lng) { (jsonDic:JSON!) -> Void in
            self.searchBar.resignFirstResponder()
            if(jsonDic.arrayValue.count != 0)
            {
                for itemHotel in jsonDic.arrayValue
                {
                    self.items.append(Item(website: itemHotel["provider"]["url"].rawString()!, latLng: itemHotel["latLng"].arrayObject as! [Double], price: itemHotel["price"]["nightly"].rawString()!, location: itemHotel["location"]["all"].rawString()!, reviews: itemHotel["reviews"]["rating"].rawString()!, photos: itemHotel["photos"].arrayObject!, attr: itemHotel["attr"].dictionaryObject!))
                }
                self.activeLoad()
                self.myCollectionView.reloadData()
            }
            else
            {
                self.activeLoad()
                let alert = UIAlertController(title: "Thông báo", message: "Địa điểm không có khách sạn", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func currentSearch(sender: AnyObject) {
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.searchPlace("21.01484", lng: "105.84660")
    }
    //delegate searchBar
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        AlamofireRequest.sharedInstance.getLatLng(searchBar.text!) { (location: JSON) -> Void in
            
            
            for location in location.arrayValue
            {
                let tempLocation = location["geometry"]["location"]
                self.searchPlace(tempLocation["lat"].rawString()!, lng: tempLocation["lng"].rawString()!)
            }
        }
    }
    
    
    //delegate collectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ItemCell
        let imageURL = items[indexPath.item].photos[0]["large"] as! String
        cell.price.text = items[indexPath.item].price! + "$"
        cell.nameLabel.text = items[indexPath.item].attr["heading"] as? String
        if ((items[indexPath.item].attr["isCalAvailable"] as? Bool!) == false)
        {
            cell.isAvarible.text = "Hết Phòng"
        }
        if let image = self.imageCache.objectForKey(imageURL) as? UIImage { // Use the local cache if possible
            cell.imageView.image = image
        } else { // Download from the internet
            cell.activeLoad()
            AlamofireRequest.sharedInstance.getImage(imageURL) { (data: NSData!) -> Void in
                cell.activeLoad()
                if let image = UIImage(data: data)
                {
                    self.imageCache.setObject(image, forKey:imageURL)
                    cell.imageView.image = image
                    self.myCollectionView.reloadItemsAtIndexPaths([indexPath])
                    self.items[indexPath.item].imgProfile = image
                }
                else
                {
                    cell.imageView.image = UIImage(named: "placeholder")
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
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // We will set our updateSize value if it's nil.
        if (updatedSize == nil) {
            // At this point, the correct ViewController frame is set.
            self.updatedSize = self.view.frame.size
        }
        // If your collectionView is full screen, you can use the
        // frame size to judge whether you're in landscape.
        if (self.updatedSize.width > self.updatedSize.height) {
            return CGSize(width: self.updatedSize.width/2 - 15, height: self.updatedSize.height / 2)
        } else {
            return CGSize(width: self.updatedSize.width/2 - 15, height: self.updatedSize.height / 3)
        }
    }
    // Finally, update the size of the updateSize property, every time
    // viewWillTransitionToSize is called.  Then performBatchUpdates to
    // adjust our layout.
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updatedSize = size
        self.myCollectionView!.performBatchUpdates(nil, completion: nil)
    }
    //func navigation bar
    func OpenViewLogin()
    {
        let detailView = self.storyboard?.instantiateViewControllerWithIdentifier("MainView") as? MainView
        self.presentViewController(detailView!, animated: true, completion: nil)
//        self.navigationController!.pushViewController(detailView!, animated: true)
    }
}
