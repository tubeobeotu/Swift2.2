
//  CapSoNhan.swift
//  Day02
//
//  Created by techmaster on 8/19/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit
infix operator  ^^ { }  //Toán tử nằm giữa 2 toán hạng: A ^^ B
//prefix: toán tử nằm trước toán hạng ^^A , ++A
//postfix: toán tử nằm sau toán hạng  A^^, A--

func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

class CapSoNhan: UIViewController {

    @IBOutlet weak var powerNumber: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func calculate(sender: AnyObject) {
        var test = power(3.0, powerNum: 3.0)
        print("test = \(test)")
        test = power(2.0, powerNum: 10.0)
        print("test = \(test)")
        
        let test2 = 2 ^^ 3
        print("test = \(test2)")
        
        let test3 = recursivePower(10, power: 4)
        print("test = \(test3)")
    }
    
    func power(num: Float, powerNum: Float) ->Float {
        let result: Float = pow(num, powerNum)
        return result
    }
   
    
    func power2(radix: Double, power: Double) -> Double {
        let result = pow(radix, power)
        return result
    }

    //Hàm gọi đệ quy
    func recursivePower(radix: Double, power: Int16) -> Double {
        if power == 1 {
            return radix
        } else {
            return radix * recursivePower(radix, power: power - 1)
        }
    }
}
