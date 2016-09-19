//
//  TableViewCellSong.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class TableViewCellSong: TableViewCellBase {
    var btn_Play: UIButton!
    var btn_AddPlayList: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addBtn_Play()
        addBtn_AddPlayList()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .None
    }
    
    func addBtn_Play()
    {
        btn_Play = UIButton()
        btn_Play.setImage(UIImage(named: "btn_play"), forState: .Normal)
        self.contentView.addSubview(btn_Play)
        btn_Play.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: btn_Play, attribute: .Leading, relatedBy: .Equal, toItem: lbl_name, attribute: .Trailing, multiplier: 1.0, constant: 5)
        let cn2 = NSLayoutConstraint(item: btn_Play, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: self.contentView.center.y - 15)
        
        let cn3 = NSLayoutConstraint(item: btn_Play, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        
        let cn4 = NSLayoutConstraint(item: btn_Play, attribute:  .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn3, cn4])
    }
    func addBtn_AddPlayList()
    {
        btn_AddPlayList = UIButton()
        btn_AddPlayList.addTarget(self, action: #selector(clickAddPlayList), forControlEvents: .TouchUpInside)
        btn_AddPlayList.setImage(UIImage(named: "btn_playList"), forState: .Normal)
        self.contentView.addSubview(btn_AddPlayList)
        btn_AddPlayList.translatesAutoresizingMaskIntoConstraints = false
        let cn1 = NSLayoutConstraint(item: btn_AddPlayList, attribute: .Leading, relatedBy: .Equal, toItem: btn_Play, attribute: .Trailing, multiplier: 1.0, constant: 5)
        let cn2 = NSLayoutConstraint(item: btn_AddPlayList, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1.0, constant: self.contentView.center.y - 15)
        
        let cn3 = NSLayoutConstraint(item: btn_AddPlayList, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        
        let cn4 = NSLayoutConstraint(item: btn_AddPlayList, attribute:  .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 30)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn3, cn4])
    }
    func clickAddPlayList()
    {
        print("Click Click")
    }
    
    
    
    
    
    
    
    
    
    
}
