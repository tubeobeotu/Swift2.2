//
//  ViewController.swift
//  GirlPhoto
//
//  Created by cuong minh on 11/28/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var girl: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onSlide(sender: UISlider) {
        girl.alpha = CGFloat(sender.value)
    }


}

