//
//  Fibonacci.swift
//  Day02
//
//  Created by techmaster on 8/19/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class Fibonacci: UIViewController {
    @IBOutlet weak var number: UITextField!

    @IBOutlet weak var fibonacciLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateFibonacciArray(10)
    }
    //Hãy thử với num > 95
    //Hãy thử viết lại bằng recursive function
    func generateFibonacciArray(num: Int) ->[Int64] {
        var result:[Int64] = Array(count:num, repeatedValue:0)
      
        result[1] = 1
        for var i = 2; i < num; i++ {
            result[i] = result[i-1] + result[i-2]
            print("\(i) = \(result[i])")
        }
        
        return result
    }
    @IBAction func generateAndDisplay(sender: AnyObject) {
        
        if let number = Int(self.number.text!) {
            var result = self.generateFibonacciArray(number)
            var string = ""
            for i in 0..<number {  //Hãy thử với for i in 0...number
                string += "\(result[i]), "
            }
            self.fibonacciLabel.text = string
        } else {
            print("Couldn't convert to a number")
        }
    }
    
    func sampleFunc() {
        let individualScores = [75, 43, 103, 87, 12]
        var teamScore = 0
        var totalScore = 0
        for score in individualScores {
            if score > 50 {
                teamScore += 3
            } else {
                teamScore += 1
            }
            totalScore += score
        }
        var averageScore: Float = Float(totalScore) / Float(individualScores.count)
    }
}