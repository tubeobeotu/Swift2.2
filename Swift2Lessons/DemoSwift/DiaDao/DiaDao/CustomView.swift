//
//  CustomView.swift
//  VisualSort
//
//  Created by Tuuu on 5/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class CustomView: UIView {
    var value = String()
    var active = false
    var sorted = false
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        
    }
    init(frame: CGRect, value: String)
    {
        super.init(frame: frame)
        if (value == "*") {
            self.backgroundColor = UIColor.redColor()
        }
        else if (value == "!")
        {
            self.backgroundColor = UIColor.brownColor()
        }
        else
        {
            self.backgroundColor = UIColor.greenColor()
        }  
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
