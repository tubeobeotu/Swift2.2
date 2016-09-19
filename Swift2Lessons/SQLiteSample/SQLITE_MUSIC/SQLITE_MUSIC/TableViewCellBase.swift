//
//  TableViewCellBase.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class TableViewCellBase: UITableViewCell {

    var img_Detail: UIImageView!
    var lbl_name: UILabel!
    var lbl_info: UILabel!
    var cn_lblName = NSLayoutConstraint()
    var cn_lblInfo = NSLayoutConstraint()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addImgDetail()
        addName()
        addInfo()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    func addImgDetail()
    {
        img_Detail = UIImageView()
        img_Detail.contentMode = .ScaleToFill
        self.contentView.addSubview(img_Detail)
        img_Detail.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: img_Detail, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1.0, constant: 5)
        let cn2 = NSLayoutConstraint(item: img_Detail, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0)
        
        let cn3 = NSLayoutConstraint(item: img_Detail, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 84)
        
        let cn4 = NSLayoutConstraint(item: img_Detail, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 84)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn3, cn4])
        
    }
    func addName()
    {
        lbl_name = UILabel()
        self.contentView.addSubview(lbl_name)
        lbl_name.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: lbl_name, attribute: .Leading, relatedBy: .Equal, toItem: img_Detail, attribute: .Trailing, multiplier: 1.0, constant: 2)
        let cn2 = NSLayoutConstraint(item: lbl_name, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: 0)
        
        let cn3 = NSLayoutConstraint(item: lbl_name, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 35)
        
        cn_lblName = NSLayoutConstraint(item: lbl_name, attribute:  .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: -100)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn_lblName, cn3])
    }
    func addInfo()
    {
        lbl_info = UILabel()
        self.contentView.addSubview(lbl_info)
        lbl_info.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: lbl_info, attribute: .Leading, relatedBy: .Equal, toItem: img_Detail, attribute: .Trailing, multiplier: 1.0, constant: 2)
        let cn2 = NSLayoutConstraint(item: lbl_info, attribute: .Top, relatedBy: .Equal, toItem: lbl_name, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        let cn3 = NSLayoutConstraint(item: lbl_info, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 35)
        
        cn_lblInfo = NSLayoutConstraint(item: lbl_info, attribute:  .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1.0, constant: -100)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn3, cn_lblInfo])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
