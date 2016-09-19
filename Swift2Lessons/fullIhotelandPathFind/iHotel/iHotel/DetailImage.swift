//
//  DetailImage.swift
//  iHotel
//
//  Created by DangCan on 1/27/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit

class DetailImage: BaseController, UIScrollViewDelegate {

    @IBOutlet weak var photo: UIImageView!
    var img = UIImage()
    var add = false
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        add = true
        photo.image = img
        photo.contentMode = .ScaleAspectFit
        scrollView.maximumZoomScale = 2
        scrollView.delegate = self
        

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo
    }

}
