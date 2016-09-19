//
//  CustomCellMaster.swift
//  CustomizeTableViewCell
//
//  Created by hoangdangtrung on 1/7/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class CustomCellMaster: UITableViewCell {

    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelFootballClub: UILabel!
    @IBOutlet weak var labelStadium: UILabel!
    @IBOutlet weak var imageViewStarRating: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
