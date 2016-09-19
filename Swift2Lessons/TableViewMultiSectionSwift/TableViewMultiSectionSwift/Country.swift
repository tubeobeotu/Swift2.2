//
//  File.swift
//  TableViewMultiSectionSwift
//
//  Created by hoangdangtrung on 12/29/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class Country {
    var name: String
    var capitalCity: String
    
    init (string: String) {
        var country_capital: NSArray
        country_capital = string.componentsSeparatedByString("|")
        self.name = country_capital[0] as! String
        self.capitalCity = country_capital[1] as! String
    }
}

