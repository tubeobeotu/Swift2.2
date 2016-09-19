//
//  ViewController.swift
//  RollingBall
//
//  Created by DangCan on 5/17/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ball = UIImageView()
    var timer = NSTimer()
    var radians = CGFloat()
    var ballRadious = CGFloat()
    var traiquaphai = true
    override func viewDidLoad() {
        super.viewDidLoad()
        addBall()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: #selector(rollBall), userInfo: nil, repeats: true)
    }
    
    func addBall()
    {
        let mainViewSize = self.view.bounds.size
        ball = UIImageView(image: UIImage(named: "ball.png"))
        ballRadious = 32.0
        ball.center = CGPointMake(ballRadious, mainViewSize.height * 0.5)
        self.view.addSubview(ball)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    func rollBall()
    {
        var deltaAngle: CGFloat = 0.1
        if (traiquaphai == false) {
            deltaAngle = -0.1
        }
        if (ball.center.x + 32.0 > self.view.bounds.width)
        {
            traiquaphai = false
            ballRadious = -ballRadious
        }
        if (ball.center.x - 32.0 < 0)
        {
            traiquaphai = true
        }
        radians = radians + deltaAngle
        ball.transform = CGAffineTransformMakeRotation(radians)
        ball.center = CGPointMake(ball.center.x + ballRadious * deltaAngle, ball.center.y)
        
        
    }
    
    
}

