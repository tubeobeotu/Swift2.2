//
//  WorldData.swift
//  TableViewMultiSectionSwift
//
//  Created by hoangdangtrung on 12/29/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit
/*
Change the import statement to import UIKit instead of Foundation
By default, a Swift file imports the Foundation framework so you can work with Foundation data structures in your code.
You’ll be working with a class from the UIKit framework, so you need to include UIKit in your import statement.
Importing UIKit also gets you access to Foundation, so you can remove the redundant import to Foundation.
*/

class WorldData {
    var arrayContinents: NSArray!
    class var sharedData: WorldData {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var worldData: WorldData? = nil
        }
        dispatch_once(&Static.onceToken) { () -> Void in
            Static.worldData = WorldData()
        }
        return Static.worldData!
    }
    
    init() {
        let filePath: String = NSBundle.mainBundle().pathForResource("Data", ofType: "plist")!
        let array = NSArray(contentsOfFile: filePath)!
        let tempArray: NSMutableArray = NSMutableArray(capacity: array.count)
        
        for dict in array {
            let tempCountries: [AnyObject] = dict["countries"] as! [AnyObject]
            let arrayCountries: NSMutableArray = NSMutableArray(capacity: tempCountries.count)
            for string in tempCountries {
               arrayCountries.addObject(Country.init(string: string as! String))
            }
            tempArray.addObject(Continent.init(name: dict["continent"] as! String, countries: arrayCountries))
        }
        
        arrayContinents = tempArray
    }
}


//Use the class constant approach if you are using Swift 1.2 or above and the nested struct approach if you need to support earlier versions.

//Approach A: Class constant
/*
class WorldData {
    
    static let sharedData = WorldData()
    
    init() {
        print("AAA");
    }
}
*/


/*
Approach B: Nested struct

class SingletonB {
    
    class var sharedInstance: SingletonB {
        struct Static {
            static let instance: SingletonB = SingletonB()
        }
        return Static.instance
    }
}
*/
















