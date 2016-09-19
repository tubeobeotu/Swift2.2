//
//  RootView.swift
//  MyBooks
//
//  Created by CanDang on 1/5/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class RootView: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }

    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        delegateType!.valueDidChange("PDF")
    }
    
    
}
