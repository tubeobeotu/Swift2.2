import UIKit
import XCPlayground

let url = NSURL(string: "http://techmaster.vn/fileman/Uploads/logo/nodejs.jpg")

let image = UIImage(data: NSData(contentsOfURL: url!)!)

let imageView = UIImageView(image: image)

imageView.frame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: (image?.size)!)

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

XCPlaygroundPage.currentPage.liveView = containerView

containerView.addSubview(imageView)

//imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))

imageView.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation(CGFloat(M_PI_2)), CGAffineTransformMakeScale(0.5, 0.5))







