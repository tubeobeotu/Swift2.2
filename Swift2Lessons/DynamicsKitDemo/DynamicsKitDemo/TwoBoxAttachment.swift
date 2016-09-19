//
//  TwoBoxAttachment.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/17/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class TwoBoxAttachment: UIViewController {

    
    @IBOutlet weak var dragPoint: UIImageView!
    @IBOutlet weak var dragPointA: UIImageView!
    @IBOutlet weak var attachPointA: UIImageView!
    @IBOutlet weak var attachPointB: UIImageView!
    @IBOutlet weak var squareA: UIView!
    @IBOutlet weak var squareB: UIView!
    
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    var attachmentBehaviorA: UIAttachmentBehavior?
    var attachmentBehaviorB: UIAttachmentBehavior?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        configureDynamicKit()
        configureAttachment()
    }
    func configureDynamicKit() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
     /*   gravity.gravityDirection = CGVectorMake(0.0, 0.8) //Thử đổi giá trị x, y của vector xem kết quả thế nào
        animator!.addBehavior(gravity)*/
        
        collider.translatesReferenceBoundsIntoBoundary = true  //Chuyển reference thành khung để giới hạn chuyển động
        animator!.addBehavior(collider)
    }
    
    func configureAttachment() {
        let squareASize = squareA.bounds.size
        //offset được định nghĩa dựa vào khoảng cách giữa tâm của hình vuông và attachPoint
        let offsetA = UIOffset(horizontal: attachPointA.center.x - squareASize.width * 0.5, vertical: attachPointA.center.y - squareASize.height * 0.5)
        
        dragPoint.tintColor = UIColor.redColor()
        dragPoint.image = dragPoint.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        attachmentBehaviorA = UIAttachmentBehavior(item: squareA, offsetFromCenter: offsetA, attachedToAnchor: dragPoint.center)
        animator!.addBehavior(attachmentBehaviorA!)
        
        attachPointA.tintColor = UIColor.blueColor()
        attachPointA.image = attachPointA.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
       
        //--------
        let squareBSize = squareB.bounds.size
        let offsetB = UIOffset(horizontal: attachPointB.center.x - squareBSize.width * 0.5, vertical: attachPointB.center.y - squareBSize.height * 0.5)
        attachmentBehaviorB = UIAttachmentBehavior(item: squareB, offsetFromCenter: offsetB, attachedToAnchor: squareA.center)
        animator!.addBehavior(attachmentBehaviorB!)
        
        
        dragPoint.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "onMoveDragPoint:"))
        
        //Track để vẽ một dash line từ dragPoint đến attachPoint của square. Do attachPoint nằm trong square. Do đó phải dùng đến attachmentOffset
        (self.view as! LineView).trackAndDrawAttachmentFromView(dragPoint, attachedView: squareA, attachmentOffset: CGPoint(x: offsetA.horizontal, y: offsetA.vertical))
        
        squareA.addObserver(self, forKeyPath: "center", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    func onMoveDragPoint(sender: UIPanGestureRecognizer) {
        attachmentBehaviorA!.anchorPoint = sender.locationInView(self.view)
        dragPoint.center = attachmentBehaviorA!.anchorPoint
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if(object as! UIView == squareA){
            attachmentBehaviorB!.anchorPoint = squareA.center
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

}
