//
//  ViewController.swift
//  IAmRich
//
//  Created by techmaster on 7/29/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var gem: UIImageView!
    //Không có ! không biên dịch được
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gem.alpha = 0.0;
        self.view.backgroundColor = UIColor.blackColor()
        label = UILabel(frame: CGRectMake(0, 0, 300, 40))
        label.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height + 20)
        label.text = "Welcome to iOS 9 Swift!"
        label.textColor = UIColor.whiteColor()
        label.font = label.font.fontWithSize(25)
        label.font = UIFont(name: "KaushanScript-Regular", size: 20)
       
        label.textAlignment = NSTextAlignment.Center  //Canh text ở giữa khung 300x40
        self.view.addSubview(label)
        
    }
    
    override func viewWillAppear(animated: Bool)  {
        super.viewWillAppear(animated)
        
       /* Animation đơn giản
        UIView.animateWithDuration(5, animations: {
            self.gem.alpha = 1.0
            })*/
        
        // Animation phức tạp hơn
        UIView.animateWithDuration(2, animations: {
                self.gem.alpha = 1.0
            }, completion: {(Bool) in
                print("Gem is shown!")
                
                UIView.animateWithDuration(1, animations: {
                        self.label.center = CGPointMake(self.label.center.x, 300)
                })
            })
        
     
    }


}

