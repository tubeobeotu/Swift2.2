//
//  Song.swift
//  CrawlVideo
//
//  Created by Tuuu on 6/21/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
struct Song {
    var title = ""
    var artistName = ""
    var thumbnail: UIImage
    var sourceOnline = ""
    var sourceLocal = ""
    let baseThumbnail = "http://image.mp3.zdn.vn//thumb/240_240/"
    var localThumbnail = ""
    init(title: String, artistName: String, thumbnail: String, source: String)
    {
        self.title = title
        self.artistName = artistName
        let thumbnailURL = baseThumbnail+thumbnail
        let dataImage = NSData(contentsOfURL: NSURL(string: thumbnailURL)!)
        self.thumbnail = UIImage(data: dataImage!)!
        self.sourceOnline = source
    }
    init(title: String, artistName: String, localThumbnail: String, localSource: String){
        self.title = title
        self.artistName = artistName
        self.localThumbnail = localThumbnail
        let dataImage = NSData(contentsOfFile: self.localThumbnail)
        self.thumbnail = UIImage(data: dataImage!)!
        self.sourceLocal = localSource
    }
    
}