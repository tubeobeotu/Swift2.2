//
//  ViewController.swift
//  mp3.zing
//
//  Created by DangCan on 5/17/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo!.alpha = 0
        text!.alpha = 0
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animateWithDuration(4, animations: { 
            self.logo!.alpha = 1
            }) { (finished) in
                UIView.animateWithDuration(3, animations: {
                    self.text!.center = CGPointMake(self.logo!.center.x, 100)
                    self.text!.alpha = 1
                })
        }
    }

    


}

