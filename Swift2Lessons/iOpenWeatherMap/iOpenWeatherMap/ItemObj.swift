//
//  ItemObj.swift
//  iOpenWeatherMap
//
//  Created by hoangdangtrung on 1/23/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class ItemObj {
    var temp: Int!
    var location: String!
    var imgMainWeather: UIImage!
    var windSpeed: String!
    var humidity: String!
    var rainVolume: String!
    var description: String!
    var date: String!
    var hour: String!
    
    init(temp: Float, location: String, date: NSString, mainWeather: String, windSpeed: String, humidity: String, rainVolume: String, var description: NSString) {
        self.temp = Int(round(temp))
        self.location = location
        self.imgMainWeather = UIImage(named: mainWeather)
        self.date = date.substringToIndex(10)
        self.hour = date.substringWithRange(NSRange(location: 11, length: 2))
        
        if var windSpeedTamp = Float(windSpeed) {
            windSpeedTamp = windSpeedTamp*3.6
            windSpeedTamp = roundf(windSpeedTamp*100)/100 // Làm tròn đến 2 số sau dấu phẩy
            self.windSpeed = "\(windSpeedTamp)"
        }
        
        if var rainVolumeTamp = Float(rainVolume) {
            rainVolumeTamp = roundf(rainVolumeTamp*100)/100 // Làm tròn đến 2 số sau dấu phẩy
            self.rainVolume = "\(rainVolumeTamp)"
        }
        
        let firstLetterDesCription = description.substringToIndex(1).capitalizedString // Viết hoa chữ cái đầu tiên
        description = description.stringByReplacingCharactersInRange(NSRange(location: 0, length: 1), withString: firstLetterDesCription)
        self.description = description as String
        
        self.humidity = humidity
    }
}
