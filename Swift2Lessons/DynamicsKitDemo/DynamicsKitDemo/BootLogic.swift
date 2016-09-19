//
//  BootLogic.swift
//  TechmasterSwiftApp
//
//  Created by Adam on 9/8/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//  Techmaster Vietnam

import UIKit
let SECTION = "section"
let MENU = "menu"
let TITLE = "title"
let CLASS = "class"
class BootLogic: NSObject {
    
    var menu : NSArray?
    class func boot(window:UIWindow){
        let mainScreen = MainScreen(style: UITableViewStyle.Grouped)
        
        var basic = [SECTION: "Basic",MENU:[
            [TITLE: "Simple Gravity",CLASS: "SimpleGravity"],
            [TITLE: "Gravity",CLASS: "Gravity"],
            [TITLE: "Attachment",CLASS: "AttachmentCollision"],
            [TITLE: "Two Boxes Attachment",CLASS: "TwoBoxAttachment"],
            [TITLE: "Attach Spring Gravity",CLASS: "AttachSpringGravity"],
            [TITLE: "Snap",CLASS: "Snap"],
            [TITLE: "Draw Handle",CLASS: "DrawHandle"]
          ]
        ]
      
       
        
        mainScreen.menu = [basic]
        mainScreen.title = "UIView - Controls"
        mainScreen.about = "Đây là ứng dụng minh hoạ UIView - Controls"
        
        let nav = UINavigationController(rootViewController: mainScreen)
        
        window.rootViewController = nav        
      
    }   
}
