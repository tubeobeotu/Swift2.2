//
//  ViewPlaylists.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/20/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import UIKit
class ViewPlayLists: UITableViewControllerBase, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SelectItem{
    var currentID = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        super.myTableView.delegate = self
        super.myTableView.dataSource = self
        txt_Search.delegate = self
        getDataSong("1", statement: "")
        getArtistWithSongID()
        setupListView()
        loadTitle(currentIndexOption)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupListView()
    }
    override func setupListView()
    {
        labels = getPlayList()
        listView.delegateSelectItem = self
        listView.items = labels
        listView.type = Type.PLAYLIST
    }
    func getDataSong(id: String, statement: String)
    {
        items.removeAll()
        items = dataBase.viewDatabase("PLAYLIST", columns: ["*"], statement: "JOIN DetailPlayList On PLAYLIST.Id = DetailPlayList.PlayListId JOIN SONGS On SONGS.Id = DetailPlayList.SONGID where PLAYLIST.Id = \(id) \(statement)")
        super.myTableView.reloadData()
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var name = ""
        //Trường hợp string == "" nghĩa là đang xoá
        if (string == "")
        {
            //Lớn hơn không mới cắt để tránh lỗi
            if (textField.text!.characters.count > 0)
            {
                name = (textField.text! as NSString).substringToIndex(textField.text!.characters.count - 1)
            }
            else
            {
                name = ""
            }
        }
            //trường hợp tăng string lên
        else
        {
            name = "\(textField.text!)\(string)"
        }
        self.getDataSong(String(currentID), statement: "And SONGS.SongName Like '\(name)%'")
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
        cell!.type = Type.PLAYLIST
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
        return PlayList(id: currentItem["ID"] as! Int, playListName: currentItem["PlaylistName"] as! NSString, song: Song(id: currentItem["SongID"] as! Int, songName: currentItem["SongName"] as! NSString, urlImg: currentItem["UrlImg"] as! String))
    }
    
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
    //delegate
    func selectPlayList(id: Int) {
        currentIndexOption = id
        loadTitle(id)
        getDataSong(String(id), statement: "")
        getArtistWithSongID()
    }
    
}