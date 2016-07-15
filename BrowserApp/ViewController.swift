//
//  ViewController.swift
//  BrowserApp
//
//  Created by Pranav Kasetti on 15/07/2016.
//  Copyright © 2016 Pranav Kasetti. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string:"http://www.appcoda.com")
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
        print(webView)
    }
    
    override func viewWillAppear(animated: Bool) {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0)
        self.view.addConstraints([height, width])
        self.view.setNeedsUpdateConstraints()
        self.view.setNeedsLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.webView = WKWebView(frame: CGRectZero)
        super.init(coder: aDecoder)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

