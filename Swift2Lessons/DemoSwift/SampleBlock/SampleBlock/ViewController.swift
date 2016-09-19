//
//  ViewController.swift
//  SampleBlock
//
//  Created by Tuuu on 6/7/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let queue = dispatch_queue_create("hehe", DISPATCH_QUEUE_CONCURRENT)
    var imgs = ["http://top10for.com/wp-content/uploads/2015/02/Hottest-Victoria%E2%80%99s-Secret-Models1.jpg"]
    var block1: ((p1: Int, p2: String) -> Int)?
    var block2 = {(p1: Int) -> () in
        print(p1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        printSomething(9, completion: {() in
            print("Block da hoan thanh")
        })
    }
    
    func printSomething(p1: Int, completion:() -> ())
    {
        print(p1)
        completion()
    }
    
    func loadData(completion: (data: NSData, index: Int) -> ())
    {
        let queue = dispatch_queue_create("com.tech", DISPATCH_QUEUE_CONCURRENT)
        for stringUrl in self.imgs
        {
            if let url = NSURL(string: stringUrl)
            {
                dispatch_sync(queue, { 
                    if let data = NSData(contentsOfURL: url)
                    {
                        completion(data: data, index: self.imgs.indexOf(stringUrl)!)
                    }
                })
            }
        }
    }
    @IBAction func a_Print(sender: AnyObject)
    {
        
        
    }
    @IBAction func a_Load(sender: AnyObject)
    {
        dispatch_async(dispatch_get_global_queue(0, 0)) { 
            self.loadData { (data, index) in
                //            print("Done")
                dispatch_async(dispatch_get_main_queue(), {
                    if let imgView = self.view.viewWithTag(100+index) as? UIImageView
                    {
                        imgView.image = UIImage(data: data)
                    }
                })
                
            }
        }
        
    }
    
    
}

