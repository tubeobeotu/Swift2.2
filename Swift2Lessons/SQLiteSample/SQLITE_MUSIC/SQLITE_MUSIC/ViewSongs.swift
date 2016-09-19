//
//  ViewSongs.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewSongs: ViewControllerTableBase, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SelectedItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        txt_Search.delegate = self
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.listView.delegateSelected = self
        
        
        myTableView.registerClass(TableViewCellSong.self, forCellReuseIdentifier: "Cell")
        getDataSong("")
        getArtistWithSongID()
        loadItemsForListView()
    }
    func loadItemsForListView()
    {
        itemsOfListView = [Label(displayName: "Name", id: 1, column: "SongName"), Label(displayName: "ID", id: 2, column: "ID")]
    }
    override func chooseOrder() {
//        getDataSong("Order by SongName ASC")
    }
    func getDataSong(statement: String)
    {()
        items = self.dataBase.viewDataBase("SONGS", columns: ["*"], statement: statement)
        self.myTableView.reloadData()
    }
    
    
//#MARK: TextField delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var statement = ""
        //Trường hơkp stirng == "" nghĩa là đang xoá
        if (string == "")
        {
            if (textField.text!.characters.count > 0)
            {
                statement = (textField.text! as NSString).substringToIndex(textField.text!.characters.count - 1)
            }
            else
            {
                statement = ""
            }
        }
        //Trường hợp tằng string
        else
        {
            statement = "\(textField.text!)\(string)"
        }
        self.getDataSong("Where SongName Like '\(statement)%'")
        return true
    }
    
    
//#MARK: TableView DataSource
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("Cell") as! TableViewCellBase
        let currentItem = items[indexPath.row]
        cell.img_Detail.image = UIImage(named: currentItem["UrlImg"] as! String)
        cell.lbl_name.text = currentItem.objectForKey("SongName") as? String
        cell.lbl_info.text = nameArtists[indexPath.row]
        return cell
    }
//#MARK: Protocol Selected
    func selectedOrder(id: Int) {
        getDataSong("Order by \(self.itemsOfListView[id - 1].column) ASC")
    }
    
    
    
    
    
    
    
    
}
