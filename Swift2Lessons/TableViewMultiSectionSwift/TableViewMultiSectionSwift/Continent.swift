
//
//  Continent.swift
//  TableViewMultiSectionSwift
//
//  Created by hoangdangtrung on 12/29/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class Continent {
    var name: String
    var arrayCountries: NSArray
    
    init(name: String, countries: NSArray) {
        self.name = name
        self.arrayCountries = countries
    }
}
