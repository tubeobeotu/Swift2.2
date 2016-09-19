//
//  AlamofireRequest.swift
//  iHotel
//
//  Created by DangCan on 1/20/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamofireRequest{
    class var sharedInstance: AlamofireRequest {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AlamofireRequest? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AlamofireRequest()
        }
        return Static.instance!
    }
    func getInformationOfItemVia(latitude: String, longitude: String, completion: ((list : JSON!) -> Void)?) {
        //---  block code.
        let manager = Alamofire.Manager.sharedInstance
        let headers = ["Accept": "application/json","X-Mashape-Key": "tKxQHTDGAbmsh3dKmcUkZOz0utf1p1ZyJ4OjsnDxjp0ybJQGxP"]
        let params = ["latitude" : latitude,"longitude":longitude] as Dictionary!
        manager.request(.GET, "https://zilyo.p.mashape.com/search",parameters: params, headers: headers).responseJSON { response in
            let json = JSON(data: response.data!);
            let jsonDic = json["result"]
            completion!(list: jsonDic)
        }
    }
    
    func getImage(path: String, completion: ((data : NSData!) -> Void)?)
    {
        let manager = Alamofire.Manager.sharedInstance
        manager.request(.GET, path).response{ _, _, data, error in
            if let error = error {
                print("Failed with error: \(error)")
            } else {
                completion!(data: data)
            }
        }
    }
    
    func getLatLng(name: String, completion: ((location : JSON) -> Void)?)
    {
        let path = "http://maps.googleapis.com/maps/api/geocode/json?address=\(name)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let manager = Alamofire.Manager.sharedInstance
        manager.request(.GET, path!).responseJSON{ response in
            let json = JSON(data: response.data!);
            let jsonDic = json["results"]
            completion!(location: jsonDic)
        }
        }
    }
    
    func downloadImage(path: String, completion: ((list : NSData!) -> Void)?)
    {
        
        
        //        let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
        //            (temporaryUrl, response)  in
        //            if response.statusCode == 200 {
        //                if NSFileManager.defaultManager().fileExistsAtPath(ProfitApp.JsonUrl.path!) {
        //                    try! NSFileManager.defaultManager().removeItemAtURL(ProfitApp.JsonUrl)
        //                }
        //                return ProfitApp.DocumentDirectoryUrl.URLByAppendingPathComponent(ProfitApp.JsonFileName)
        //            }
        //            else {
        //                return temporaryUrl
        //            }
        //        }
        //        let download = Alamofire.download(.GET, "http://www.hotelcoandi.ro/static/galleries/hotel/l/hotel.jpg", destination: destination)
        //        download.progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
        //            print(totalBytesRead)
        //
        //            // This closure is NOT called on the main queue for performance
        //            // reasons. To update your ui, dispatch to the main queue.
        //            dispatch_async(dispatch_get_main_queue()) {
        //                print("Total bytes read on main queue: \(totalBytesRead)")
        //            }
        //            }
        //            .response { _, _, _, error in
        //                if let resumeData = download.resumeData
        //                {
        //                    completion!(list: resumeData)
        //                } else {
        //                    print("Resume Data was empty")
        //                }
        //        }
        //        Alamofire.download(.GET, "http://www.hotelcoandi.ro/static/galleries/hotel/l/hotel.jpg", destination: destination)
        //            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
        //                print(destination)
        //                print(totalBytesRead)
        //
        //                // This closure is NOT called on the main queue for performance
        //                // reasons. To update your ui, dispatch to the main queue.
        //                dispatch_async(dispatch_get_main_queue()) {
        //                    print("Total bytes read on main queue: \(totalBytesRead)")
        //                }
        //            }
        //            .response { _, _, data, error in
        //                if let error = error {
        //                    print("Failed with error: \(error)")
        //                } else {
        //                    print("Downloaded file successfully")
        //                }
        //        }
        
        
    }
    struct ProfitApp {
        static let DocumentDirectoryUrl = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!)
        static let JsonFileName = "profitdata-2.json"
        static let JsonUrl = ProfitApp.DocumentDirectoryUrl.URLByAppendingPathComponent(ProfitApp.JsonFileName)
    }

