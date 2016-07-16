//
//  ViewController.swift
//  BrowserApp
//
//  Created by Pranav Kasetti on 15/07/2016.
//  Copyright © 2016 Pranav Kasetti. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    @IBAction func reload(sender: UIBarButtonItem) {
        let request = NSURLRequest(URL:webView.URL!)
        webView.loadRequest(request)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        barView.frame = CGRect(x:0, y: 0, width: view.frame.width, height: 30)
        setupWebView()
        self.webView.navigationDelegate = self
        self.webView.addObserver(self, forKeyPath: "loading", options: .New, context: nil)
        loadHomepage()
        backButton.enabled = false
        forwardButton.enabled = false
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func setupWebView() {
        self.webView = WKWebView()
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -44)
        let width = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: webView, attribute: .Width, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: webView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0)
        
        self.view.addSubview(webView)
        self.view.addConstraints([height, width, leading, top])
    }
    
    func loadHomepage() {
        let url = NSURL(string:"http://www.facebook.com")
        let request = NSURLRequest(URL:url!)
        self.webView.loadRequest(request)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        urlField.resignFirstResponder()
        
        let url = NSURL(string: urlField.text!)!
        if UIApplication.sharedApplication().canOpenURL(url) {
        webView.loadRequest(NSURLRequest(URL: url))
        } else {
            let alert = UIAlertController(title: "Error", message: "Invalid URL! Please enter a valid URL", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
        return false
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "loading") {
            backButton.enabled = webView.canGoBack
            forwardButton.enabled = webView.canGoForward
        }
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        barView.frame = CGRect(x:0, y: 0, width: size.width, height: 30)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

