//
//  ViewFilter.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/30/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit
class ViewFilter: UIImageView {
    var imageFilter: UIImage?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func getImageFilter(filter: CIFilter) -> UIImage
    {
        let outputImage = filter.outputImage
        let ciContext = CIContext()
        let ouptImageRef = ciContext.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let uiImage = UIImage(CGImage: ouptImageRef)
        return uiImage
    }
}