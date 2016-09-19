//
//  DetailBook.swift
//  MyBooks
//
//  Created by CanDang on 1/4/16.
//  Copyright © 2016 CanDang. All rights reserved.
//

import UIKit

class DetailBook: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var btnShowDate: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var myActive: UIActivityIndicatorView!
    @IBAction func action(sender: AnyObject)
    {
        self.webView.stringByEvaluatingJavaScriptFromString("hello();")
    }
    var urlString : String = ""
    var type: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = urlString
//         set webview delegate
        self.webView.delegate = self
        
        // fit content within screen size.
        self.webView.scalesPageToFit = true
        
        // start spinner
        self.myActive.startAnimating()
        var urlpath = "default"
        // load url content within webview
        switch(type)
        {
            case "PDF" : urlpath = NSBundle.mainBundle().pathForResource(urlString, ofType: "pdf")!
            self.btnShowDate.hidden = true
            case "DOCX" : urlpath = NSBundle.mainBundle().pathForResource(urlString, ofType: "docx")!
            self.btnShowDate.hidden = true
            case "HTML" : urlpath = NSBundle.mainBundle().pathForResource(urlString, ofType: "html")!
            self.btnShowDate.hidden = false
            default : break
        }
        let url:NSURL = NSURL.fileURLWithPath(urlpath)
        //        if let urlToBrowse = NSURL.fileURLWithPath(urlpath!) {
        let urlRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
        //        }
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.myActive.hidden = true
        self.myActive.stopAnimating()
    }
    func webViewDidStartLoad(webView: UIWebView)
    {
        print("")
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        print("")
        return true
    }
    
    

}
