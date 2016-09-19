//
//  MasterVC.swift
//  DemoPrepareForSegue
//
//  Created by Cuong Trinh on 1/5/16.
//  Copyright © 2016 MyStudio. All rights reserved.
//

import UIKit

class MasterVC: UITableViewController {

    var data: [String]!
    var detailVC: DetailVC!
    override func viewDidLoad() {
        super.viewDidLoad()
        data = ["Cat", "Dog", "Tiger"]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellID", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row]
    

        return cell
    }
    

    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "MasterDetail" {
            return false
        } else  {
            return true
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("didSelectRowAtIndexPath")
        if detailVC == nil {
            //detailVC = DetailVC(nibName: "DetailVC", bundle: nil)
            detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as! DetailVC
        } else {
            print("reuse detail view controller")
            
        }
        
        detailVC.labelText = data[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      print("prepareForSegue")
    }
    

}
