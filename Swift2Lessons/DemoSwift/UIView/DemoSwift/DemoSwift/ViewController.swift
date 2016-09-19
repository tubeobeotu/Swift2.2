//
//  ViewController.swift
//  DemoSwift
//
//  Created by Tuuu on 5/18/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl_NoiDung: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func acction_Print(sender: AnyObject) {
        print("Mình ấn vào nút này")
        lbl_NoiDung
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

