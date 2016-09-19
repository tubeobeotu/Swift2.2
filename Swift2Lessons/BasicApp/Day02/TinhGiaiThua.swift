//
//  TinhGiaiThua.swift
//  Day02
//
//  Created by techmaster on 8/20/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
postfix operator ^! {}

postfix func ^! (number: Int) -> Int {
    if number == 0 || number == 1 {
        return 1
    }
    
    var result = 1
    for i in 2...number {
        result *= i
    }
    return result
}
class TinhGiaiThua: UIViewController {

    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let r4 = 5^!
        print("5! = \(r4)")
        var string = ""
        for i in 1...20 {
            let r = i^!
            string += "\(i)! = \(r)\n"
        }
        self.result.text = string
    }

}
