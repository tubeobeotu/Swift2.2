//
//  AttachmentCollision.swift
//  DynamicsKitDemo
//
//  Created by Trinh Minh Cuong on 10/15/14.
//  Copyright (c) 2014 vn.Techmsater. All rights reserved.
//

import UIKit

class AttachmentCollision: UIViewController {

    @IBOutlet weak var dragPoint: UIImageView!
    @IBOutlet weak var attachPoint: UIImageView!
    @IBOutlet weak var square: UIView!
    
    var animator: UIDynamicAnimator?
    let gravity = UIGravityBehavior()
    let collider = UICollisionBehavior()
    var attachmentBehavior: UIAttachmentBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        configureDynamicKit()
        configureAttachment()
    }
    func configureDynamicKit() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity.gravityDirection = CGVectorMake(0.0, 0.8) //Thử đổi giá trị x, y của vector xem kết quả thế nào
        animator!.addBehavior(gravity)
        
        collider.translatesReferenceBoundsIntoBoundary = true  //Chuyển reference thành khung để giới hạn chuyển động
        animator!.addBehavior(collider)
    }
    
    func configureAttachment() {
        let squareSize = square.bounds.size
        //offset được định nghĩa dựa vào khoảng cách giữa tâm của hình vuông và attachPoint
        let offset = UIOffset(horizontal: attachPoint.center.x - squareSize.width * 0.5, vertical: attachPoint.center.y - squareSize.height * 0.5)
      
        dragPoint.tintColor = UIColor.redColor()
        dragPoint.image = dragPoint.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        attachmentBehavior = UIAttachmentBehavior(item: square, offsetFromCenter: offset, attachedToAnchor: dragPoint.center)
        animator!.addBehavior(attachmentBehavior!)
        
        attachPoint.tintColor = UIColor.blueColor()
        attachPoint.image = attachPoint.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        dragPoint.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "onMoveDragPoint:"))
        
        //Track để vẽ một dash line từ dragPoint đến attachPoint của square. Do attachPoint nằm trong square. Do đó phải dùng đến attachmentOffset
        (self.view as! LineView).trackAndDrawAttachmentFromView(dragPoint, attachedView: square, attachmentOffset: CGPoint(x: offset.horizontal, y: offset.vertical))
        
    }
    
    func onMoveDragPoint(sender: UIPanGestureRecognizer) {
        attachmentBehavior!.anchorPoint = sender.locationInView(self.view)
        dragPoint.center = attachmentBehavior!.anchorPoint
    }

}
