//
//  GameManager.swift
//  gameFish
//
//  Created by CanDang on 12/24/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    var fishViews : NSMutableArray?
    var hookView : HookerView?
    override init()
    {
        self.fishViews = NSMutableArray()
        self.hookView = HookerView(frame: CGRectMake(0, -490, 20, 490))
    }
    func addFishToviewController(viewcontroller:UIViewController,
        width:Int)
    {
        let fishView = FishView(frame: CGRectMake(0, 0, 40, 30))
        fishView.generateFish(width)
        self.fishViews?.addObject(fishView)
        viewcontroller.view.addSubview(fishView)
    }
    func updateMove()
    {
        self.hookView?.updateMove()
        for fishView in self.fishViews!
        {
            fishView.updateMove()
            
            if (CGRectContainsPoint(fishView.frame, CGPointMake(self.hookView!.center.x, self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)))
            {
                bite (fishView as! FishView)
            }
        }
    }
    func dropHookerAtX(x: Int)
    {
        self.hookView?.dropDownAtX(x)
    }
    func bite(fishView: FishView)
    {
        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP && self.hookView?.status != self.hookView?.CAUGHTF)
        {
            fishView.caught()
            fishView.center = CGPointMake(self.hookView!.center.x, self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHTF
        }
    }
    
}
