//
//  ViewControllerTableBase.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/23/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit

class ViewControllerTableBase: ViewControllerBase {
    var myTableView: UITableView!
    var nameArtists = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        
    }
    func getArtistWithSongID()
    {
        for song in items
        {
            let detail = dataBase.viewDataBase("DETAILALBUM", columns: ["ARTISTS.ArtistName"], statement: "JOIN ARTISTS on DETAILALBUM.ArtistID = ARTISTS.ID where SONGID = \(song["ID"]!)")
            nameArtists.append(detail.first!["ArtistName"] as! String)
        }
    }
    func addTableView()
    {
        myTableView = UITableView()
        myTableView.backgroundColor = UIColor.brownColor()
        self.view.addSubview(myTableView)
        
        //contraint
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let cn1 = NSLayoutConstraint(item: myTableView, attribute: .Leading, relatedBy: .Equal, toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 0)
        let cn2 = NSLayoutConstraint(item: myTableView, attribute: .Trailing, relatedBy: .Equal, toItem: self.view, attribute: .Trailing, multiplier: 1.0, constant: 0)
        let cn3 = NSLayoutConstraint(item: myTableView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 104)
        let cn4 = NSLayoutConstraint(item: myTableView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activateConstraints([cn1, cn2, cn3, cn4])
        
    }



    
    
    
    
    
    

}
