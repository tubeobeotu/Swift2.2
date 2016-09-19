//
//  ViewController.swift
//  EarthAroundSun
//
//  Created by DangCan on 5/17/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = NSTimer()
    var sun = UIImageView()
    var earth = UIImageView()
    var sunCenter = CGPoint()
    var earthCenter = CGPoint()
    var distanceEarthToSun = CGFloat()
    var angle = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor.blackColor()
        addSunAndEarth()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.0167, target: self, selector: #selector(spinEarth), userInfo: nil, repeats: true)
    }
    func addSunAndEarth(){
        sun = UIImageView(image: UIImage(named: "sun.png"))
        earth = UIImageView(image: UIImage(named: "moon.png"))
        let mainViewSize = self.view.bounds.size
        sunCenter = CGPointMake(mainViewSize.width * 0.5, mainViewSize.height * 0.5)
        distanceEarthToSun = 50.0
        sun.center = sunCenter
        angle = 0.0
        earth.center = computePositionOfEarch(angle)
        self.view.addSubview(sun)
        self.view.addSubview(earth)
    }
    func computePositionOfEarch(angle: CGFloat) -> CGPoint
    {
        return CGPointMake(sunCenter.x + distanceEarthToSun * cos(angle), sunCenter.y + distanceEarthToSun * sin(angle))
    }
    func spinEarth()
    {
        angle = angle + 0.01
        earth.center = computePositionOfEarch(angle)
    }


}

