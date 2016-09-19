//
//  DetailItem.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import SafariServices
import FBSDKShareKit
class DetailItem: BaseController, SFSafariViewControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var btn_pathFind: UIButton!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var txtVDescription: UITextView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var scrollViewContent: UIScrollView!
    var item: Item?
    let imageCache = NSCache()
    var first = false
    @IBOutlet weak var shareButton: FBSDKShareButton!
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
        
        //
        self.title = item!.attr["heading"] as? String
        address.text = item!.location
        imgProfile.image = item!.imgProfile
        price.text = "Giá:" + item!.price! + "$"
        rating.text = "Đánh giá: " + item!.reviews!
        txtVDescription.text = item!.attr["description"] as? String
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg"))
        imgProfile.addGestureRecognizer(tap)
        //
        self.imgCollectionView.dataSource = self
        self.imgCollectionView.delegate = self
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        addButtonShare()
    }
    func buttonDefault()
    {
        shareButton.enabled = false
        btn_pathFind.enabled = false
        btn_pathFind.setTitleColor(UIColor.grayColor(), forState: .Normal)
    }
    func tapImg()
    {
        let detailView = self.storyboard?.instantiateViewControllerWithIdentifier("DetailImage") as? DetailImage
        detailView?.img = imgProfile.image!
        self.navigationController!.pushViewController(detailView!, animated: true)
    }
    func addButtonShare()
    {
        shareButton.enabled = false
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            shareButton.enabled = true
            let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: item!.website!)
            content.contentTitle = item!.attr["heading"] as? String
            content.contentDescription = "<INSERT STRING HERE>"
            content.imageURL = NSURL(string: item!.photos[0]["large"] as! String)
            shareButton.shareContent = content
        }
        if let user = GIDSignIn.sharedInstance().currentUser
        {
            if (user.profile != nil)
            {
                btn_pathFind.enabled = true
            }
        }
        
        
    }
    @IBAction func pathFind(sender: AnyObject) {
        let mapView = PathFind(nibName: "PathFind", bundle: nil)
        mapView.addressString = item!.location
        self.navigationController?.pushViewController(mapView, animated: true)
        
    }
    //delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item!.photos.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CellDetail
        let imageURL = item!.photos[indexPath.item]["large"] as! String
//        cell.addSubviews(false)
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
    //func navigation bar
    func OpenViewLogin()
    {
        let detailView = self.storyboard?.instantiateViewControllerWithIdentifier("MainView") as? MainView
        self.presentViewController(detailView!, animated: true, completion: nil)
    }
}
