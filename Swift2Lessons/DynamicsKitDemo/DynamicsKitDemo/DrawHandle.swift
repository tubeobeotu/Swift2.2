//
//  DrawHandle.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/18/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class DrawHandle: UIViewController {

    @IBOutlet weak var pointA: UIImageView!
    @IBOutlet weak var pointB: UIImageView!
    var handle: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pointA.tintColor = UIColor.redColor()
        pointB.tintColor = UIColor.blueColor()
        pointA.image = pointA.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        pointB.image = pointB.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        pointA.userInteractionEnabled = true
        pointB.userInteractionEnabled = true
        
        pointA.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "onPanPoint:"))
        pointB.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "onPanPoint:"))
    }
    
    func onPanPoint (sender: UIPanGestureRecognizer) {
        let panPoint = sender.locationInView(self.view)
        sender.view?.center = panPoint
    }

}
