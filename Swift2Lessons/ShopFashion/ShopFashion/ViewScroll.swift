//
//  ViewScroll.swift
//  ShopFashion
//
//  Created by CanDang on 1/8/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class ViewScroll: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageController: UIPageControl!
    var frontScrollView: [UIScrollView] = []
    var pageImages: [String] = []
    var pageViews: [UIImageView?] = []
    var currentImgView = 0
    var first = false
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.currentPage = currentImgView
        pageController.numberOfPages = pageImages.count
        
        
    }
    override func viewDidLayoutSubviews() {
        if (!first)
        {
            first = true
            // 4
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(pageImages.count), 0)
            // 5
            for i in 0 ... pageImages.count - 1
            {
                let imgView = UIImageView(image: UIImage(named:pageImages[i]+".jpg"))
                imgView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)
                imgView.contentMode = .ScaleAspectFit
                imgView.userInteractionEnabled = true
                imgView.multipleTouchEnabled = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapImg(_:)))
                tap.numberOfTapsRequired = 1
                imgView.addGestureRecognizer(tap)
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTabImg(_:)))
                doubleTap.numberOfTapsRequired = 2
                imgView.addGestureRecognizer(doubleTap)
                tap.requireGestureRecognizerToFail(doubleTap)
                pageViews.append(imgView)
                
                
                let frontScrollView1 = UIScrollView(frame: CGRectMake( CGFloat(i) * scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height))
                frontScrollView1.minimumZoomScale = 1
                frontScrollView1.maximumZoomScale = 2
                frontScrollView1.delegate = self
                frontScrollView1.contentSize = imgView.bounds.size
                frontScrollView1.addSubview(imgView)
                frontScrollView.append(frontScrollView1)
                self.scrollView.addSubview(frontScrollView1)
            }
            scrollView.contentOffset = CGPointMake(CGFloat(currentImgView) * scrollView.frame.size.width, 0)
        }
    }
    
    func tapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTabImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(pageViews[pageController.currentPage])
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(scale: CGFloat, center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        frontScrollView[pageController.currentPage].zoomToRect(zoomRect, animated: true)
    }
    //uiscrollview delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return pageViews[pageController.currentPage]
    }
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat)
    {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((self.scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        if (pageController.currentPage != page)
        {
            frontScrollView[pageController.currentPage].zoomScale = 1
            pageController.currentPage = page
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
    }
    
    
    
}
