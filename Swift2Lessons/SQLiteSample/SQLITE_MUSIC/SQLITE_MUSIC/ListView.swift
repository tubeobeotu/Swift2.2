//
//  ListView.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ListView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var delegateSelected: SelectedItem!
    var items = [Label]()
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.delegate = self
        self.dataSource = self
    }
//# MARK: DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCellWithIdentifier("Cell")
        let currentItem = items[indexPath.row]
        cell?.textLabel?.text = currentItem.displayName
        cell?.textLabel?.textAlignment = .Center
        return cell!
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegateSelected.selectedOrder!(items[indexPath.row].id)
    }
    
    
    
    
    
    
    
}
