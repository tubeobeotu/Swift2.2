//
//  ViewController.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items: [Item] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var myDict: NSDictionary?
        if let path = NSBundle.mainBundle().pathForResource("items", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        for dic in myDict!.allValues
        {
            items.append(Item(name: dic["name"] as! String, content: dic["content"] as! String, nameImages: dic["images"] as! NSArray as! [String], price: dic["price"] as! String))
        }
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ACell", forIndexPath: indexPath) as! ACellItem
        cell.addSubviews()
        cell.imageView.contentMode = .ScaleAspectFit
        cell.imageView.image = UIImage(named: items[indexPath.item].nameImages[0]+".jpg")
        cell.nameLabel.text = items[indexPath.item].name
        cell.price.text = items[indexPath.item].price
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewDetailShop") as? ListImages
        listView?.item = items[indexPath.item]
        self.navigationController?.pushViewController(listView!, animated: true)
        
    }
}

