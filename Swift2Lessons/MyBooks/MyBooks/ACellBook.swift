//
//  ACellBook.swift
//  MyBooks
//
//  Created by CanDang on 1/4/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit
let kCellWidth: CGFloat = 66
let kLabelHeight: CGFloat = 20
class ACellBook: UICollectionViewCell {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(kCellWidth, kCellWidth + kLabelHeight);
    }
    
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            imageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(imageView)
        }
        
        if (nameLabel == nil) {
            nameLabel = UILabel(frame: CGRectMake(0, kCellWidth, kCellWidth, kLabelHeight))
            nameLabel.textAlignment = .Center
            nameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            nameLabel.highlightedTextColor = tintColor
            nameLabel.font = UIFont.systemFontOfSize(12)
            contentView.addSubview(nameLabel)
        }
    }
    
    override var selected: Bool {
        didSet {
            imageView.layer.borderWidth = selected ? 2 : 0
        }
    }
    
}
