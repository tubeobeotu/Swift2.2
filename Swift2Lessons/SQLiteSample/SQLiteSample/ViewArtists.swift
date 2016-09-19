//
//  ViewArtists.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewArtists: UITableViewControllerBase, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SelectItem{
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("")
        setupListView()
        loadTitle(currentIndexOption)
    }
    
    //delegate
    func selectArtistsOption(id: Int) {
        currentIndexOption = id
        loadTitle(id)
        getDataSong("Order by \(labels[id - 1].column) ASC")
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupListView()
    }
    override func setupListView()
    {
        labels = getALlArtistOrder()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.ARTISTS
    }
    func getDataSong(statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("ARTISTS", columns: ["*"], statement: statement)
        super.myTableView.reloadData()
    }
    func getALlArtistOrder() -> [Label]
    {
        return [Label(displayName: "Name", id: 1, column: "ArtistName")]
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var statement = ""
        //Trường hợp string == "" nghĩa là đang xoá
        if (string == "")
        {
            //Lớn hơn không mới cắt để tránh lỗi
            if (textField.text!.characters.count > 0)
            {
                statement = (textField.text! as NSString).substringToIndex(textField.text!.characters.count - 1)
            }
            else
            {
                statement = ""
            }
        }
            //trường hợp tăng string lên
        else
        {
            statement = "\(textField.text!)\(string)"
        }
        self.getDataSong("Where ArtistName Like '\(statement)%'")
        return true
    }
    
    //# MARK:Delegate UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "UITableViewCellBase", bundle: nil) , forCellReuseIdentifier: "Cell")
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCellBase
        let currentItem = items[indexPath.row]
        cell!.object = getCurrentObject(currentItem)
        cell!.type = Type.ARTISTS
        //        cell!.delegateSelect = self
        if nameArtists.count == items.count
        {
            cell?.nameItem = nameArtists[indexPath.row]
        }
        
        cell?.changeInfo()
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 84
    }
    
    //
    func getCurrentObject(currentItem: NSDictionary) -> NSObject
    {
        return Artist(id: currentItem["ID"] as! Int, artistName: currentItem["ArtistName"] as! NSString,  born: currentItem["Born"] as! NSString, urlImg: currentItem["UrlImg"] as! NSString)
    }
    
}