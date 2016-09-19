//
//  ViewController.swift
//  PopoverController
//
//  Created by DangCan on 5/12/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popOverController = UIPopoverController(contentViewController: popView)
        popOverController.popoverContentSize = CGSize(width: 100, height: 100)
        popOverController.presentPopoverFromRect(CGRectMake(0, 0, 200, 200), inView: self.view, permittedArrowDirections:.Down, animated: true)
    }
    
    @IBAction func action(sender: UIButton){
      
        
    }

    


}

