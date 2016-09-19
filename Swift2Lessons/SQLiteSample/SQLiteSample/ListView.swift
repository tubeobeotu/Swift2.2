//
//  ListView.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/21/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ListView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var items = [Label](){
        didSet {
            self.frame.size = CGSize(width: 200, height: items.count * 50)
        }
    }
    var delegateSelectItem: SelectItem!
    var type = Type.NONE
    //# MARK: INIT
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
        self.layer.borderColor = UIColor(red: 251/255, green: 125/255, blue: 4/255, alpha: 1.0).CGColor
//        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
    }
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor(colorLiteralRed: 24/255, green: 27/255, blue: 34/255, alpha: 1.0)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 251/255, green: 125/255, blue: 4/255, alpha: 1.0).CGColor
//        self.separatorStyle = .None
        self.delegate = self
        self.dataSource = self
    }
    //# MARK: Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.dequeueReusableCellWithIdentifier("Cell")
        let currentItem = items[indexPath.row]
        if (cell == nil)
        {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        }
        cell?.selectionStyle = .Default
        cell?.textLabel?.text = currentItem.displayName
        cell?.textLabel?.textAlignment = .Center
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.blackColor()
        
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectOption(indexPath.row)
        self.hidden = true
    }
    func selectOption(index: Int)
    {
        switch type {
        case .SONGS:
            self.delegateSelectItem.selectSongsOption!(items[index].id)
            break
        case .ALBUMS:
            self.delegateSelectItem.selectAlbumsOption! (items[index].id)
            break
        case .ARTISTS:
            self.delegateSelectItem.selectArtistsOption!(items[index].id)
            break
        case .GENRE :
            self.delegateSelectItem.selectGenre!(items[index].id)
        case .PLAYLIST:
            self.delegateSelectItem.selectPlayList!(items[index].id)
            break
        default:
            self.deselectRowAtIndexPath(self.indexPathForSelectedRow!, animated: false)
            break
        }
    }
}