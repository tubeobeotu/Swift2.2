//
//  DrawZigZag.swift
//  Day02
//
//  Created by techmaster on 8/19/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class DrawZigZag: UIViewController {

    @IBOutlet weak var result: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawZigZag()
        self.result.text = self.stringZigZag()
    }

    func drawZigZag () {
        print("    *     ")
        print("   *  *   ")
        print("  *    *  ")
        print(" *      * ")
        print("*        *")
    }
    
    func stringZigZag () -> String {
        var result = ""
        result += "    *     \n"
        result += "   *  *   \n"
        result += "  *    *  \n"
        result += " *      * \n"
        result += "*        *\n"
        return result
    }

    
}
