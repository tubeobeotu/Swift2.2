//
//  ItemCell.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import Alamofire
class ItemCell: UICollectionViewCell {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    var isVailable: UIImageView!
    var isCalAvailable = true
    var price: UILabel!
    var kPriceLabelHeight: CGFloat = 20
    var kCellWidth: CGFloat = 100
    var kCellHeight: CGFloat = 120
    var kLabelHeight: CGFloat = 20
    var request: Alamofire.Request?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(kCellWidth, kCellWidth + kLabelHeight);
    }
    
    func addSubviews(addAll: Bool) {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellHeight))
            imageView.layer.borderColor = tintColor.CGColor
            imageView.contentMode = .ScaleToFill
            contentView.addSubview(imageView)
        }
        
        if (addAll)
        {
            if (isVailable == nil)
            {
                isVailable = UIImageView(frame: CGRectMake(0, 0, 20, 20))
                isVailable.contentMode = .ScaleToFill
                contentView.addSubview(isVailable)
                if (isCalAvailable)
                {
                    isVailable.image = UIImage(named: "available")
                }
                else
                {
                    isVailable.image = UIImage(named: "notavailable")
                }
            }
            if (nameLabel == nil) {
                nameLabel = UILabel(frame: CGRectMake(0, kCellHeight, kCellWidth, kLabelHeight))
                nameLabel.textAlignment = .Left
                nameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
                nameLabel.numberOfLines = 2
                nameLabel.font = UIFont.systemFontOfSize(12)
                contentView.addSubview(nameLabel)
            }
            if (price == nil) {
                price = UILabel(frame: CGRectMake(0, kCellHeight + kLabelHeight, kCellWidth, kPriceLabelHeight))
                price.textAlignment = .Left
                price.textColor = UIColor(red: 97/255, green: 164/255, blue: 73/255, alpha: 1)
                price.font = UIFont.boldSystemFontOfSize(16)
                contentView.addSubview(price)
            }
        }
    }
    
    override var selected: Bool {
        didSet {
            imageView.layer.borderWidth = selected ? 2 : 0
        }
    }
    
}
