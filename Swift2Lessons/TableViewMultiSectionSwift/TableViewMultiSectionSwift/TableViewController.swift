//
//  TableViewController.swift
//  TableViewMultiSectionSwift
//
//  Created by hoangdangtrung on 12/29/15.
//  Copyright © 2015 hoangdangtrung. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var arrayContinent: NSArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayContinent = WorldData.sharedData.arrayContinents
    }
    
    override func viewWillAppear(animated: Bool) {
        WorldData.sharedData
    }



    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayContinent.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let continent: Continent = arrayContinent[section] as! Continent
        return continent.arrayCountries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let continent = arrayContinent[indexPath.section] as! Continent
        let country = continent.arrayCountries[indexPath.row] as! Country
        
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.capitalCity
        cell.imageView?.image = UIImage(named: country.name)
        
        // Change image size
        let itemSize: CGSize = CGSizeMake(100, 66)
        UIGraphicsBeginImageContext(itemSize)
        let imageRect: CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
        cell.imageView?.image?.drawInRect(imageRect)
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return cell
    }
    
    /// -----------------------------------------------------------------------------------------------------
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.brownColor()
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let continent: Continent = arrayContinent[section] as! Continent
        return continent.name
    }
    

}

















