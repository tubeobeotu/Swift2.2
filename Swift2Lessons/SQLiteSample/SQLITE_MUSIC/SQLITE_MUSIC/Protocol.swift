//
//  Protocol.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation

@objc protocol SelectedItem
{
    optional func selectedOrder(id: Int)
}