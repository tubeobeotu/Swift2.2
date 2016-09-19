//
//  ViewController.swift
//  InstantWeather
//
//  Created by techmaster on 7/29/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var quote: UILabel!
 
    
    let quotes = ["Dục tốc bất đạt", "Có công mài sắt có ngày nên kim", "Con đường dẫn đến thành công, không có dấu chân của kẻ lười biếng", "Uốn miệng 7 lần trước khi nói", "10 năm trồng cây, 100 năm trồng người"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func onRefresh(sender: UIButton) {
        let ranIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        self.quote.text = quotes[ranIndex]
       
        let temp =  NSString(format: "%2.1f", getTemperature())
        self.temperature.text = "\(temp)"
        
    }
    
    func randomQuote() -> String {
        let ranIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        return quotes[ranIndex]
    }
    
    func getTemperature() -> Float {
        
        return 14.0 + Float(arc4random_uniform(18)) + Float(arc4random()) / Float(UINT32_MAX)
    }

}

