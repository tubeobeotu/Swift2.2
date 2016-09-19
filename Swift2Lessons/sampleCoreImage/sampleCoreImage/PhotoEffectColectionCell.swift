//
//  PhotoEffectColectionCell.swift
//  sampleCoreImage
//
//  Created by CanDang on 12/30/15.
//  Copyright © 2015 CanDang. All rights reserved.
//

import UIKit

class PhotoEffectColectionCell: UICollectionViewCell {
    let kCellWidth: CGFloat = 66
    let kLabelHeight: CGFloat = 20
    var filterNameLabel: UILabel!
    var filteredImageView: ViewFilter!
    var filter : CIFilter?
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
        if (filteredImageView == nil) {
            filteredImageView = ViewFilter(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            filteredImageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(filteredImageView)
        }
        
        if (filterNameLabel == nil) {
            filterNameLabel = UILabel(frame: CGRectMake(0, kCellWidth, kCellWidth, kLabelHeight))
            filterNameLabel.textAlignment = .Center
            filterNameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
            filterNameLabel.highlightedTextColor = tintColor
            filterNameLabel.font = UIFont.systemFontOfSize(12)
            contentView.addSubview(filterNameLabel)
        }
    }
    override var selected: Bool
    {
        didSet
        {
            filteredImageView.layer.borderWidth = selected ? 2 : 0
        }
    }
}
