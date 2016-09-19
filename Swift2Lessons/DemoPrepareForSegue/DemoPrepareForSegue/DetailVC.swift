//
//  DetailVC.swift
//  DemoPrepareForSegue
//
//  Created by Cuong Trinh on 1/5/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    var labelText: String!    
    
    override func viewWillAppear(animated: Bool) {
        label.text = labelText
    }

    

}
