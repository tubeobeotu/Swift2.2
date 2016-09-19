//
//  DetailTableVC.swift
//  DynamicTableView
//
//  Created by hoangdangtrung on 12/25/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class DetailTableVC: UITableViewController {
    
    var stringTitle: String!
    var dictData = NSDictionary()
    var arrayKeys = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createDataWithName(stringTitle)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = stringTitle

    }
    
    func createDataWithName(title: String) {
        var path: String = ""
        if (title == "Fruits") {
            path = NSBundle.mainBundle().pathForResource("FruitsList", ofType: "plist")!
        }
        if (title == "Animals") {
            path = NSBundle.mainBundle().pathForResource("AnimalsList", ofType: "plist")!

        }
        dictData = NSDictionary(contentsOfFile: path)!

        arrayKeys = dictData.allKeys
        arrayKeys = arrayKeys.sortedArrayUsingSelector("localizedCaseInsensitiveCompare:")
        
        
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayKeys.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let key: String = (arrayKeys[indexPath.row] as? String)!
        cell.textLabel!.text = key
        cell.imageView?.image = UIImage(named: "\(dictData[key]!)")
        
        return cell
    }
    

}











