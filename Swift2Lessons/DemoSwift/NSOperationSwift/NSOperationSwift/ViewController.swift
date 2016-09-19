//
//  ViewController.swift
//  NSOperationSwift
//
//  Created by Tuuu on 6/17/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let opQ = NSOperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func actionCancel(sender: UIButton)
    {
        opQ.cancelAllOperations()
    }
    @IBAction func actionOp(sender: UIButton)
    {

        
        opQ.maxConcurrentOperationCount = 1
        let opBlock = NSBlockOperation()
        opBlock.addExecutionBlock {
            for _ in 0...100000
            {
                print("opB1")
            }
        }
        opBlock.completionBlock = {
            print("Done1")
        }
        
        
        let opBlock2 = NSBlockOperation()
        opBlock2.addExecutionBlock {
            for _ in 0...100
            {
                print("opB2")
            }
        }
        opBlock2.completionBlock = {
            print("Done2")
        }
        
        
        let opBlock3 = NSBlockOperation()
        opBlock3.addExecutionBlock {
            for _ in 0...100
            {
                print("opB3")
            }
        }
        opBlock3.completionBlock = {
            print("Done3")
        }
        
        
        
        let opBlock4 = NSBlockOperation()
        opBlock4.addExecutionBlock {
            for _ in 0...100
            {
                print("opB4")
            }
        }
        opBlock4.completionBlock = {
            print("Done4")
        }
        
        let opBlock5 = NSBlockOperation()
        opBlock5.addExecutionBlock {
            for _ in 0...100
            {
                print("opB5")
            }
        }
        opBlock5.completionBlock = {
            print("Done5")
        }
        
        opBlock.queuePriority = .VeryLow
        opBlock2.queuePriority = .VeryLow
        opBlock3.queuePriority = .VeryLow
        opBlock4.queuePriority = .VeryHigh
        opBlock5.queuePriority = .VeryLow
        opBlock5.addDependency(opBlock4)
        
        opBlock5.dependencies
        let opp = Operation(name: "Nguyen Van Tu")
        
        opQ.addOperation(opp)
        opQ.addOperation(opBlock)
        opQ.addOperation(opBlock2)
        opQ.addOperation(opBlock3)
        opQ.addOperation(opBlock4)
        opQ.addOperation(opBlock5)
    }
}
class Operation: NSOperation
{
    var nameOp: String
    init(name: String) {
        nameOp = name
        super.init()
    }
    override func main() {
        for _ in 0...1000
        {
            print("op \(nameOp)")
        }
    }
}

