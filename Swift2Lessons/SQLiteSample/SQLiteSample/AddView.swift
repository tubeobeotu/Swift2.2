//
//  AddView.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/12/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class AddView: UIViewController, SelectItem{
    @IBOutlet weak var lbl_Album: UILabel!
    @IBOutlet weak var lbl_ArtistName: UILabel!
    @IBOutlet weak var lbl_Genre: UILabel!
    @IBOutlet weak var txt_Name: UITextField!
    @IBOutlet weak var txt_ImgName: UITextField!
    let database = DataBase.sharedInstance
    var listView = ListView(frame: CGRectMake(0, 0, 100, 100), style: .Plain)
    var labels = [Label]()
    private var albumID = 0
    private var artistID = 0
    private var genreID = 0
    private var activeList = false
    
//# MARK: Override view
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForLabels()
        addListView()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for gesture in self.view.gestureRecognizers!
        {
            if (gesture.isKindOfClass(UIGestureRecognizer))
            {
                self.view.removeGestureRecognizer(gesture)
            }
        }
    }
//# MARK: Process Interface
    func setPositionForListView(sender: UILabel)
    {
        setStateForListView()
        listView.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y + sender.frame.height, sender.frame.width, 100)
        listView.reloadData()
    }
    func addListView()
    {
        listView.delegateSelectItem = self
        setStateForListView()
        self.view.addSubview(listView)
    }
    
    func addGestureForLabels()
    {
        lbl_ArtistName.userInteractionEnabled = true
        lbl_Album.userInteractionEnabled = true
        lbl_Genre.userInteractionEnabled = true
        
        let tapAlbum = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListItemsAlbum))
        lbl_Album.addGestureRecognizer(tapAlbum)
        
        let tapArtist = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListItemsArtist))
        lbl_ArtistName.addGestureRecognizer(tapArtist)
        
        let tapGenre = UITapGestureRecognizer(target: self, action: #selector(AddView.viewListGenre))
        lbl_Genre.addGestureRecognizer(tapGenre)
    }
    func setStateForListView()
    {
        listView.hidden = !listView.hidden
    }
    
//# MARK: Process Data
    func viewListItemsArtist()
    {
        labels.removeAll()
        var allArtists = [NSDictionary]()
        var statement = ""
        if (albumID == 0)
        {
            allArtists = database.viewDatabase("ARTISTS", columns: ["ID", "ArtistName"], statement: statement)
        }
        else
        {
            statement =  "JOIN ARTISTS On DETAILALBUM.ArtistID = ARTISTS.ID Where DETAILALBUM.albumID = \(albumID)"
            allArtists = database.viewDatabase("DETAILALBUM", columns: ["ARTISTS.ArtistName", "ARTISTS.ID"], statement: statement)
        }
        
        for artist in allArtists {
            labels.append(Label(displayName: artist["ArtistName"] as! String, id: artist["ID"] as! Int, column: "ArtistName"))
        }
        listView.items = labels
        listView.type = Type.ARTISTS
        setPositionForListView(lbl_ArtistName)
    }
    func viewListItemsAlbum()
    {
        labels.removeAll()
        var allAlbums = [NSDictionary]()
        var statement = ""
        if (artistID == 0)
        {
            allAlbums = database.viewDatabase("ALBUMS", columns: ["ID", "AlbumName"], statement: statement)
        }
        else
        {
            statement =  "JOIN ALBUMS On DETAILALBUM.AlbumID = ALBUMS.ID Where DETAILALBUM.artistID = \(artistID)"
            allAlbums = database.viewDatabase("DETAILALBUM", columns: ["ALBUMS.AlbumName", "ALBUMS.ID"], statement: statement)
        }
        
        for album in allAlbums {
            labels.append(Label(displayName: album["AlbumName"] as! String, id: album["ID"] as! Int, column: "AlbumName"))
        }
        listView.items = labels
        listView.type = Type.ALBUMS
        setPositionForListView(lbl_Album)
    }
    func viewListGenre()
    {
        labels.removeAll()
        let allGenres = database.viewDatabase("GENRES", columns: ["ID", "GenreName"], statement: "")

        for genre in allGenres {
            labels.append(Label(displayName: genre["GenreName"] as! String, id: genre["ID"] as! Int, column: "GenreName"))
        }
        listView.items = labels
        listView.type = Type.GENRE
        setPositionForListView(lbl_Genre)
    }
    func insertSong()
    {
        database.insertDatabase("SONGS", dict: ["SongName":"\(txt_Name.text!)", "UrlImg":"\(txt_ImgName.text!).jpg"])
        let songID = database.viewDatabase("SONGS", columns: ["Count(ID)"], statement: "").first!["Count(ID)"] as! Int
        database.insertDatabase("DETAILALBUM", dict: ["AlbumID":"\(self.albumID)", "GenreID":"\(self.genreID)", "ArtistID":"\(self.artistID)", "SongID":"\(songID)"])
    }
    func getIdArtistWithName(name: String)
    {
        
        print(database.viewDatabase("ARTISTS", columns: ["*"], statement: "Where ARTISTS.ArtistName='\(name)'"))
        print("")
    }
    
    func getTitleWithID(index: Int) -> String?
    {
        for label in labels
        {
            if (label.id == index)
            {
                return label.displayName
            }
        }
        return nil
    }
    
//# MARK: Action
    @IBAction func action_Create(sender: AnyObject) {
        if (checkRequirement())
        {
            insertSong()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else
        {
            print("Please Enter All The Required")
        }
        
    }
    func checkRequirement() -> Bool
    {
        if (albumID == 0 || artistID == 0 || genreID == 0 || txt_Name.text == "" || txt_ImgName.text == "")
        {
            return false
        }
        return true
    }
    @IBAction func action_Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        setStateForListView()
    }
    
//# MARK: Delegate Select
    func selectGenre(id: Int)
    {
        self.genreID = id
        setTitleForLabel(lbl_Genre, title: getTitleWithID(id)!)
    }
    func selectAlbumsOption(id: Int) {
        self.albumID = id
        setTitleForLabel(lbl_Album, title: getTitleWithID(id)!)
    }
    func selectArtistsOption(id: Int) {
        self.artistID = id
        setTitleForLabel(lbl_ArtistName, title: getTitleWithID(id)!)
    }
    func setTitleForLabel(sender: UILabel, title: String)
    {
        sender.text = title
    }
}
