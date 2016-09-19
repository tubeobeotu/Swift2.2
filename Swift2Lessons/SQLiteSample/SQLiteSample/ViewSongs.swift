//
//  ViewSongs.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewSongs: UITableViewControllerBase, SelectItem, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    var listViewPlaylist = ListView(frame: CGRectMake(0, 0, 200, 100), style: .Plain)
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("")
        getArtistWithSongID()
        addListViewPlaylist()
        setupListView()
        loadTitle(currentIndexOption)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupListView()
    {
        labels = getAllSongOrder()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.SONGS
    }
    
    //Interface
    func addListViewPlaylist()
    {
        listViewPlaylist.backgroundColor = UIColor.blackColor()
        listViewPlaylist.delegateSelectItem = self
        listViewPlaylist.type = Type.PLAYLIST
        listViewPlaylist.items = getPlayList()
        myTableView.addSubview(listViewPlaylist)
        setStateForListViewPlaylist()
    }
    func setStateForListViewPlaylist()
    {
        listViewPlaylist.hidden = !listViewPlaylist.hidden
        
    }
//# MARK: process data from database
    func getPlayList() -> [Label]
    {
        var labels = [Label]()
        let dicts = dataBase.viewDatabase("PlayList", columns: ["*"], statement: "")
        for item in dicts
        {
            labels.append(Label(displayName: item["PlaylistName"] as! String, id: item["ID"] as! Int, column: "PlaylistName"))
        }
        return labels
    }
    func getDataSong(statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("SONGS", columns: ["*"], statement: statement)
        super.myTableView.reloadData()
    }
    func getAllSongOrder() -> [Label]
    {
        return [Label(displayName: "Name", id: 1, column: "SongName"), Label(displayName: "ID", id: 2, column: "ID")]
    }
    func getCurrentObject(currentItem: NSDictionary) -> NSObject
    {
        return Song(id: currentItem["ID"] as! Int, songName: currentItem["SongName"] as! NSString, urlImg: currentItem["UrlImg"] as! NSString)
    }
    
//# MARK: Textfield delegate
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
        self.getDataSong("Where SongName Like '\(statement)%'")
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
        cell!.type = Type.SONGS
        cell!.delegateSelect = self
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
    
    
//# MARK: Delegate Select ListView
    func selectSongsOption(id: Int) {
        currentIndexOption = id
        loadTitle(id)
        self.getDataSong("Order by \(labels[id - 1].column) ASC")
    }
    func selectButtonAddPlayList(id: Int, point: CGPoint)
    {
        listViewPlaylist.frame.origin = point
        self.indexSong = id
        setStateForListViewPlaylist()
        myTableView.scrollEnabled = !myTableView.scrollEnabled
    }
    func selectPlayList(id: Int) {
        myTableView.scrollEnabled = true
        self.listViewPlaylist.deselectRowAtIndexPath(listViewPlaylist.indexPathForSelectedRow!, animated: true)
        let currentSong = items[self.indexSong]
        dataBase.insertDatabase("DETAILPLAYLIST", dict: ["SongID":String(currentSong["ID"]!), "PlayListID":String(id)])
    }
}