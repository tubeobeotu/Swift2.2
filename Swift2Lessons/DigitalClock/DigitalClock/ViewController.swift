//
//  ViewController.swift
//  DigitalClock
//
//  Created by Cuong Trinh on 1/12/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelPMAM: UILabel!
    
    var timer: NSTimer!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateClock()
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "updateClock", userInfo: nil, repeats: true)
    }
    func updateClock() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let requestedComponents: NSCalendarUnit = [
            NSCalendarUnit.Hour,
            NSCalendarUnit.Minute
        ]

        let components = calendar.components(requestedComponents, fromDate: date)
        var hour = components.hour
        let minutes = components.minute
        if hour > 12 {
            hour = hour - 12
            labelPMAM.text = "PM"
        } else {
            labelPMAM.text = "AM"
        }
        
        labelTime.text = padZero(hour) + ":" + padZero(minutes)
        
    }
    
    func padZero(num: Int) -> String {
        let temp = (num < 10 ? "0":"") + String(num)
        print(temp)
        return temp
    }


}

