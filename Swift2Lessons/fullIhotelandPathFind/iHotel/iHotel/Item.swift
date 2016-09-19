//
//  Item.swift
//  ShopFashion
//
//  Created by nguyenvantu on 1/15/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class Item: NSObject {
    var website: String?
    var latLng: [Double] = []
    var price: String?
    var location: String?
    var reviews: String?
    var photos: [AnyObject] = []
    var attr: Dictionary<String, AnyObject> = Dictionary()
    var imgProfile: UIImage?
    
    init(website: String,
        latLng: [Double],
        price: String,
        location: String,
        reviews: String,
        photos: [AnyObject],
        attr: Dictionary<String, AnyObject>)
    {
        self.website = website
        self.latLng = latLng
        self.price = price
        self.location = location
        self.reviews = reviews
        self.photos = photos
        self.attr = attr
    }
    init(website: String)
    {
        self.website = website
        
    }
}
