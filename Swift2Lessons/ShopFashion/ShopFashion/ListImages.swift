//
//  ListImages.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ListImages: UIViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var nameShop: UILabel!
    @IBOutlet weak var contentShop: UITextView!
    var item: Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameShop.text = item.name
        contentShop.text = item.content
        imgProfile.image = UIImage(named: item.nameImages[0]+".jpg")
        imgProfile.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("tapImg"))
        imgProfile.addGestureRecognizer(tap)
    }
    func tapImg()
    {
        pushView(0)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.nameImages.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ACell", forIndexPath: indexPath) as! ACellItem
        cell.kCellWidth = 60
        cell.kLabelHeight = 0
        cell.kPriceLabelHeight = 0
        cell.addSubviews()
        cell.imageView.contentMode = .ScaleAspectFit
        cell.imageView.image = UIImage(named: item.nameImages[indexPath.item]+".jpg")
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        pushView(indexPath.item)
        
    }
    func pushView(intdex: Int)
    {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.pageImages = item.nameImages
        listView?.currentImgView = intdex
        self.navigationController?.pushViewController(listView!, animated: true)
    }
    
}
