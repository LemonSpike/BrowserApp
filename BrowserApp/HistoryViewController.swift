//
//  HistoryViewController.swift
//  BrowserApp
//
//  Created by Pranav Kasetti on 17/07/2016.
//  Copyright © 2016 Pranav Kasetti. All rights reserved.
//

import UIKit
import WebKit

class HistoryViewController: UITableViewController, WKNavigationDelegate {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var webItems: WKBackForwardList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.webItems)
        if self.webItems.backList.count+self.webItems.forwardList.count != 0 || self.webItems.currentItem != nil {
            hideLoadingIndicator()
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func showLoadingIndicator() {
        loadingView.hidden = false
        self.tableView.bringSubviewToFront(loadingView)
    }
    
    func hideLoadingIndicator() {
        activityIndicator.hidesWhenStopped = true
        loadingView.hidden = true
    }
    
    func reloadData() {
        super.tableView.reloadData()
        self.tableView.bringSubviewToFront(loadingView)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.webItems.currentItem != nil {
            return self.webItems.backList.count+self.webItems.forwardList.count+1
        } else {
            return self.webItems.backList.count+self.webItems.forwardList.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Website", forIndexPath: indexPath)
        cell.textLabel!.text = self.webItems.itemAtIndex(indexPath.row)?.title!
        cell.textLabel!.numberOfLines = 0
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
