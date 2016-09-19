//
//  ViewController.swift
//  NestedSquareSwift
//
//  Created by hoangdangtrung on 12/23/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawNestedSquare()
        self.performSelector("rotateAllSquares", withObject: nil, afterDelay: 2)
    }
    
    func drawNestedSquare() {
        let mainViewSize = self.view.bounds.size
        let margin = 20.0
        var rectWidth = mainViewSize.width - CGFloat(margin * 2)
        let center = CGPointMake(mainViewSize.width/2, mainViewSize.height/2)
        
        for i in 0...10 {
            var viewSquare: UIView
            if (i%2 == 0) {
                viewSquare = self.drawSquareByWidth(rectWidth, andRotate: false, atCenter: center)
            } else {
                viewSquare = self.drawSquareByWidth(rectWidth, andRotate: true, atCenter: center)
            }
            self.view.addSubview(viewSquare)
            rectWidth = rectWidth * 0.707
        }
    }
    
    func drawSquareByWidth(width: CGFloat, andRotate rotate: Bool, atCenter center: CGPoint) ->UIView {
        let squareView = UIView(frame: CGRectMake(0, 0, width, width))
        squareView.center = center
        squareView.backgroundColor = rotate ? UIColor.whiteColor() : UIColor.darkGrayColor()
        squareView.transform = rotate ? CGAffineTransformMakeRotation(CGFloat(M_PI_4)) : CGAffineTransformIdentity
        
        return squareView
    }
    
    func rotateAllSquares() {
        UIView.animateWithDuration(2.0) { () -> Void in
            for var i=0; i<self.view.subviews.count; i++ {
                if i%2 == 0 {
                    (self.view.subviews[i] as UIView).transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
                } else {
                    (self.view.subviews[i]).transform = CGAffineTransformIdentity
                }
            }
        }
    }
    
}








