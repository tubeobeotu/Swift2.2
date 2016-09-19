//
//  BreastStrokeVC.swift
//  HowToSwim
//
//  Created by cuong minh on 12/5/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

import UIKit

class BreastStrokeVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "https://www.youtube.com/watch?v=QGZ8rIy-YtI")!))
        webView.delegate = self
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

    }
    

    
}
