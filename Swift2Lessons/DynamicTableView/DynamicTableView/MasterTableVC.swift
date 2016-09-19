//
//  MasterTableVC.swift
//  DynamicTableView
//
//  Created by hoangdangtrung on 12/25/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class MasterTableVC: UITableViewController {
    
    var dictList = ["Fruits": "fruits.png", "Animals": "animals.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "English 4 Kids"
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        var arrKey = [String](dictList.keys)
        var arrValue = [String](dictList.values)
        
        cell.textLabel!.text = arrKey[indexPath.row];
        cell.imageView?.image = UIImage(named: arrValue[indexPath.row])
        
        return cell
    }
    
    // ----------------------------------------------------------------------------
    
//    // MRAK: - Table view delegate
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let detailTableVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailTableVC") as! DetailTableVC
//        
//        let selectedRowIndex: NSIndexPath = self.tableView.indexPathForSelectedRow!
//        let selectedCell: UITableViewCell = self.tableView.cellForRowAtIndexPath(selectedRowIndex)!
//        
//        detailTableVC.stringTitle = selectedCell.textLabel!.text!
//        
//        performSegueWithIdentifier("ShowDetail", sender: self)
//    }
    
    // -----------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueID = segue.identifier
        if(segueID! == "ShowDetail") {
            let detailTableVC: DetailTableVC = segue.destinationViewController as! DetailTableVC
            
            let selectedRowIndex: NSIndexPath = self.tableView.indexPathForSelectedRow!
            let selectedCell: UITableViewCell = self.tableView.cellForRowAtIndexPath(selectedRowIndex)!
            
            detailTableVC.stringTitle = selectedCell.textLabel!.text!
        }
    }
    
    
}


















