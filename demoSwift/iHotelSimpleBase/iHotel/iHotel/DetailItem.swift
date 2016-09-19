//
//  DetailItem.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import SafariServices
class DetailItem: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var txtVDescription: UITextView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var scrollViewContent: UIScrollView!
    var item: Item?
    let imageCache = NSCache()
    var first = false
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = item!.attr["heading"] as? String
        address.text = item!.location
        imgProfile.image = item!.imgProfile
        price.text = item!.price! + "$"
        rating.text = item!.reviews
        txtVDescription.text = item!.attr["description"] as? String
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Empty local image cache as they can be re-downloaded
        self.imageCache.removeAllObjects()
    }
    override func viewDidLayoutSubviews() {
        if(!first)
        {
            scrollViewContent.contentOffset = CGPointMake(0, 10)
        }
    }
    @IBAction func gotoWebsite(sender: AnyObject) {
        let sf = SFSafariViewController(URL: NSURL(string:item!.website!)!)
        sf.delegate = self
        self.presentViewController(sf, animated: true, completion: nil)
        
    }
    //delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item!.photos.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ItemCell
        let imageURL = item!.photos[indexPath.item]["large"] as! String
        cell.kCellWidth = 60
        cell.kCellHeight = 60
        cell.addSubviews(false)
        if let image = self.imageCache.objectForKey(imageURL) as? UIImage { // Use the local cache if possible
            cell.imageView.image = image
        } else { // Download from the internet
            AlamofireRequest.sharedInstance.getImage(imageURL) { (data: NSData!) -> Void in
                if let image = UIImage(data: data)
                {
                    self.imageCache.setObject(image, forKey: imageURL)
                    cell.imageView.image = image
                }
            }
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let imageURL = item!.photos[indexPath.item]["large"] as! String
        let image = self.imageCache.objectForKey(imageURL) as? UIImage
        imgProfile.image = image
        
    }
}
