//
//  ConsoleScreen.swift
//  TechmasterSwiftApp
//
//  Created by Adam on 9/8/14.
//  Copyright (c) 2014 Adam. All rights reserved.
//

import UIKit

class ConsoleScreen: UIViewController {
    weak var console:UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let console = UITextView(frame: self.view.bounds)
        console.backgroundColor = UIColor.blackColor()
        console.textColor = UIColor.greenColor()
        console.font = UIFont(name: "Courier", size: 16)
        console.editable = false
        self.view.addSubview(console)
        self.console = console
    }
    func write(string:NSString){
        let temp = NSMutableString(string: self.console.text)
        temp.appendString(string as String)
        self.console.text = temp as String
    
    }
    func writeln (string:NSString){
        let temp = NSMutableString(string: self.console.text)
        temp.appendString(string as String)
        temp.appendString("\n")
        self.console.text = temp as String    
    }
}
