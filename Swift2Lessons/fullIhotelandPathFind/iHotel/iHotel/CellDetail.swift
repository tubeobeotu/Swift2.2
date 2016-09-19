//
//  CellDetail.swift
//  iHotel
//
//  Created by DangCan on 3/14/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import Foundation
import UIKit
class CellDetail: UICollectionViewCell {
    var imageView: UIImageView!
    var kCellWidth: CGFloat = 60
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubviews()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(kCellWidth, kCellWidth);
    }
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            imageView.image = UIImage(named: "placeholder")
            imageView.layer.masksToBounds = true
            imageView.layer.cornerRadius = 1
            imageView.layer.borderColor = tintColor.CGColor
            imageView.contentMode = .ScaleToFill
            contentView.addSubview(imageView)
        }
        
    }
    override var selected: Bool {
        didSet {
            
            imageView.layer.borderWidth = selected ? 2 : 0
            
        }
    }
}