//
//  CustomCellTableView.swift
//  iOpenWeatherMap
//
//  Created by hoangdangtrung on 1/25/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class CustomCellTableView: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var labelTempMin: UILabel!
    @IBOutlet weak var labelTempMax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
