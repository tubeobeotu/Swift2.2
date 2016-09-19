//
//  LineView.swift
//  DynamicsKitDemo
//
//  Created by Trung on 8/4/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit
import QuartzCore
class LineView: UIView {
    var attachmentPointView: UIView!
    var attachedView: UIView!
    var attachmentOffset: CGPoint!
    var attachmentDecorationLayers: NSMutableArray!
    var arrowView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func drawMagnitudeVectorWithLength(length:CGFloat, angle:CGFloat, color:UIColor, temporaru:Bool){
        if(self.arrowView == nil) {
            let arrowImage = UIImage(named:"Arrow")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            let arrowImageView = UIImageView(image: arrowImage)
            arrowImageView.bounds = CGRectMake(0, 0, arrowImage.size.width, arrowImage.size.height)
            arrowImageView.contentMode = UIViewContentMode.Right
            arrowImageView.clipsToBounds = true
            arrowImageView.layer.anchorPoint = CGPointMake(0, 0.5)
            
            self.addSubview(arrowImageView)
            self.sendSubviewToBack(arrowImageView)
            self.arrowView = arrowImageView
        }
    
        self.arrowView.bounds = CGRectMake(0, 0, length, self.arrowView.bounds.size.height)
        self.arrowView.transform = CGAffineTransformMakeRotation(angle)
        self.arrowView.tintColor = color
        self.arrowView.alpha = 1
        
        if(temporaru){
            UIView.animateWithDuration(1.0, animations:{
                self.arrowView.alpha = 0
            })
        }
    }
    
    func trackAndDrawAttachmentFromView(attachmentPointView:UIView, attachedView:UIView, attachmentOffset:CGPoint){
        if(self.attachmentDecorationLayers == nil) {
            //First time initialization
            self.attachmentDecorationLayers = NSMutableArray(capacity: 4)
            for i in 0..<4 {
                let imageName = "DashStyle\((i%3)+1)"
                
                let dashImage = UIImage(named: imageName)  //Tạo ra 3 ảnh dash line
                let dashLayer = CALayer()
                dashLayer.contents = dashImage!.CGImage
                dashLayer.bounds = CGRectMake(0, 0, dashImage!.size.width, dashImage!.size.height)
                dashLayer.anchorPoint = CGPointMake(0.5, 0)
                
                //self.layer.insertSublayer(dashLayer, atIndex: 0)
                self.layer.addSublayer(dashLayer)
                self.attachmentDecorationLayers.addObject(dashLayer)
            }
        }
        // A word about performance
        // Trackin changes to the properties of any id<UIDynamicItem> involved in
        // a simulator incurs a performance cost. You will receive a callback
        // during each step in the simulator in which the tracked item is not at rest/
        // You should therefore strive to make your callback code as efficient as possible.
        
        self.attachmentPointView = attachmentPointView
        self.attachedView = attachedView
        self.attachmentOffset = attachmentOffset
        
        /*
        Đoạn code này gây lỗi
        self.attachmentPointView.removeObserver(self, forKeyPath: "center")
        self.attachedView.removeObserver(self, forKeyPath: "center")*/
        
        // Observe the "center" property of both views to know when they move
        self.attachmentPointView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
        self.attachedView.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
        
        self.setNeedsLayout()
        
    }
    
    //_____________
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        if (self.arrowView != nil ) {
            self.arrowView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
        }
        
        
        if(self.attachmentDecorationLayers != nil){
            // Here we adjust the line dash pattern visualizing the attachment 
            // between attachmentPoint and attachedView to account for a change
            // in the position of either
            
            var maxDashes = self.attachmentDecorationLayers.count
            
            var attachmentPointViewCenter = CGPointMake(self.attachmentPointView.bounds.size.width/2, self.attachmentPointView.bounds.size.height/2)
            attachmentPointViewCenter = self.attachmentPointView.convertPoint(attachmentPointViewCenter, toView: self)
            
            var attachedViewAttachmentPoint = CGPointMake(self.attachedView.bounds.size.width/2 + self.attachmentOffset.x, self.attachedView.bounds.size.height/2 + self.attachmentOffset.y)
            attachedViewAttachmentPoint = self.attachedView.convertPoint(attachedViewAttachmentPoint, toView: self)
            
            
            
            var distance:CGFloat = CGFloat(sqrt(powf(Float(attachedViewAttachmentPoint.x) - Float(attachmentPointViewCenter.x), 2.0) + powf(Float(attachedViewAttachmentPoint.y) - Float(attachmentPointViewCenter.y), 2.0)))
            
            
            var angle:CGFloat = atan2(CGFloat( attachedViewAttachmentPoint.y - attachmentPointViewCenter.y), CGFloat(attachedViewAttachmentPoint.x - attachmentPointViewCenter.x))
            
            var requiredDashes = 0
            var d:CGFloat = 0.0
            
            // Depending on the distance betweeen the two views, a smaller number of 
            // dashes may be needed to adequately visualize the attachment. Starting with the distance of 0, we add the length of each dash ulti we exceed "distance" computed previosly or we use the maximum number of allowed dashes
            
            while ( requiredDashes < maxDashes){
                
                var dashLayer:CALayer =  self.attachmentDecorationLayers[requiredDashes] as! CALayer
                if(d + CGFloat(dashLayer.bounds.size.height) < distance){
                    d += dashLayer.bounds.size.height
                    dashLayer.hidden = false
                    requiredDashes++
                    
                }else {
                    break
                }
            }
            
            // Based on the total length of the dashes we previously determined were
            // necessary to visualize the attachment, determine the spacing between each dash
            var a:CGFloat = distance - d
            var b:CGFloat = CGFloat(requiredDashes + 1)
            
            var dashSpacing:CGFloat = a / b
            
            // Hide the excess dashes
            for i in requiredDashes..<maxDashes {
                 (self.attachmentDecorationLayers[i] as! CALayer).hidden = true
            }
            
            //Disable any animations. The changes must take full effect immediately
            CATransaction.begin()
            CATransaction.setAnimationDuration(0)
            
            // Each dash layer is positioned by altering its affineTransform.
            // We combine the position of rotation into an affine transformation matrix that 
            // is assigned to each dash
            
            
            var transform:CGAffineTransform = CGAffineTransformMakeTranslation(attachmentPointViewCenter.x, attachmentPointViewCenter.y)
            transform = CGAffineTransformRotate(transform, angle - CGFloat(M_PI/2))
            
            for (var drawnDashes = 0; drawnDashes < requiredDashes; drawnDashes++){
                var dashLayer = self.attachmentDecorationLayers[drawnDashes] as! CALayer
                
                transform = CGAffineTransformTranslate(transform, 0, dashSpacing)
                dashLayer.setAffineTransform(transform)
                transform = CGAffineTransformTranslate(transform, 0, dashLayer.bounds.size.height)
            }
            CATransaction.commit()
        }
    }
    
    
    //____________________
    
     override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(object as! UIView == self.attachmentPointView || object as! UIView == self.attachedView){
            self.setNeedsLayout()
        }else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }   
    }

    

    
    deinit{
        if(self.attachmentPointView != nil){
            self.attachmentPointView.removeObserver(self, forKeyPath: "center")
        }
        if(self.attachedView != nil){
            self.attachedView.removeObserver(self, forKeyPath: "center")
        }
        
    }
    
}
