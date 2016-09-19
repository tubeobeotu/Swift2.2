//
//  ItemCell.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
class ItemCell: UICollectionViewCell {
    @IBOutlet weak var activityLoad: UIActivityIndicatorView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var isCalAvailable = true
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var isAvarible: UILabel!
    var kPriceLabelHeight: CGFloat = 20
    var kCellWidth: CGFloat = 180
    var kCellHeight: CGFloat = 140
    var kLabelHeight: CGFloat = 20
    var isHomeView = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        activityLoad.hidden = true
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(kCellWidth, kCellWidth + kLabelHeight);
    }
    func loadViewFromNib() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CustomCell", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(view);
        layer.cornerRadius = 5
    }
    func activeLoad()
    {
        if (activityLoad.isAnimating())
        {
            activityLoad.hidden = true
            activityLoad.stopAnimating()
        }
        else
        {
            activityLoad.hidden = false
            activityLoad.startAnimating()
        }
    }
}
