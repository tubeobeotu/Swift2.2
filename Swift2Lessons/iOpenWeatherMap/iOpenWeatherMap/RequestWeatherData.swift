//
//  RequestWeatherData.swift
//  iOpenWeatherMap
//
//  Created by hoangdangtrung on 1/22/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RequestWeatherData: NSObject {
    
    static let sharedInstance = RequestWeatherData()
    
    func getInforWeatherWithLocation(var location: String, completion: ((list: JSON) -> Void)) {
        
        // Replace WhiteSpace (" ") = "+"
        location = location.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        // Convert Á to A ...
        let data = location.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let stringLocation = NSString(data: data!, encoding: NSASCIIStringEncoding)!
        print(stringLocation)
        
        let manager = Alamofire.Manager.sharedInstance
        
        // "unit" : "metric" to show C degree
        let params = ["units" : "metric", "APPID" : "f4d9c92a4bd756fe44c04322aab36a8d"]
        
        //http://openweathermap.org/forecast5
        manager.request(.GET, "http://api.openweathermap.org/data/2.5/forecast?q=\(stringLocation)", parameters: params).responseJSON { response -> Void in
            let json = JSON(data: response.data!)
//            print(json)
            completion(list: json)
        }
    }
}




