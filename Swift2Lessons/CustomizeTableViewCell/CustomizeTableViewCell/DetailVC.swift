//
//  DetailVC.swift
//  CustomizeTableViewCell
//
//  Created by hoangdangtrung on 1/7/16.
//  Copyright © 2016 hoangdangtrung. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var stringTilte: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
       
   
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.title = stringTilte
        self.imageView.image = UIImage(named: "\(stringTilte).jpg")
    }
    
    
}
