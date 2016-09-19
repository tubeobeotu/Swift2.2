//
//  ViewController.swift
//  CrawlVideo
//
//  Created by Tuuu on 6/21/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import UIKit
import AVFoundation
let kDOCUMENT_DIRECTORY_PATH = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first
class CV_TableViewOnline: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var listSongs = [Song]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData()
    {
        let data = NSData(contentsOfURL:  NSURL(string: "http://mp3.zing.vn/bang-xep-hang/bai-hat-Viet-Nam/IWZ9Z08I.html?w=22&y=2016")!)
        let doc = TFHpple(HTMLData: data)
        if let elements = doc.searchWithXPathQuery("//h3[@class='title-item']/a") as? [TFHppleElement] {
            for element in elements {
                
                dispatch_async(dispatch_get_global_queue(0, 0), {
                    let id = self.getID(element.objectForKey("href"))
                    let url = NSURL(string: "http://api.mp3.zing.vn/api/mobile/song/getsonginfo?keycode=fafd463e2131914934b73310aa34a23f&requestdata={\"id\":\"\(id)\"}".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!)
                    var stringData = ""
                    do
                    {
                        stringData = try String(contentsOfURL: url!)
                    }
                    catch let error as NSError
                    {
                        print(error)
                    }
                    let json = self.convertStringToDictionary(stringData)
                    if (json != nil)
                    {
                        self.addSongToList(json!)
                    }
                    
                })
                
            }
        }
    }
    
    func addSongToList(json: [String:AnyObject])
    {
        let title = json["title"] as! String
        let artistName = json["artist"] as! String
        let thumbnail = json["thumbnail"] as! String
        let source = json["source"]!["128"] as! String
        
        
        let currentSong = Song(title: title, artistName: artistName, thumbnail: thumbnail, source: source)
        listSongs.append(currentSong)
        dispatch_async(dispatch_get_main_queue()) {
            self.myTableView.reloadData()
        }
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    func getID(path: NSString) -> NSString
    {
        let id = (path.lastPathComponent as NSString).stringByDeletingPathExtension
        return id
    }
    
    
    func downloadSong(index: Int)
    {
        let dataSong = NSData(contentsOfURL: NSURL(string:listSongs[index].sourceOnline)!)
        if let dir = kDOCUMENT_DIRECTORY_PATH {
            //writing
            let pathToWriteSong = "\(dir)/\(listSongs[index].title)"
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWriteSong, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription);
            }
            
            writeDataToPath(dataSong!, path: "\(pathToWriteSong)/\(listSongs[index].title).mp3")
            writeInfoSong(listSongs[index], path: pathToWriteSong)
            
        }
        
        
    }
    func writeInfoSong(song: Song, path: String)
    {
        let dictData = NSMutableDictionary()
        dictData.setValue(song.title, forKey: "title")
        dictData.setValue(song.artistName, forKey: "artistName")
        dictData.setValue("/\(song.title)/thumbnail.png", forKey: "localThumbnail")
        dictData.setValue(song.sourceOnline, forKey: "sourceOnline")
        //writing info
        writeDataToPath(dictData, path: "\(path)/info.plist")
        
        
        //writing thumbnail
        let dataThumbnail = NSData(data: UIImagePNGRepresentation(song.thumbnail)!)
        writeDataToPath(dataThumbnail, path: "\(path)/thumbnail.png")
        
    }
    func writeDataToPath(data: NSObject, path: String)
    {
        if let dataToWrite = data as? NSData
        {
            dataToWrite.writeToFile(path, atomically: true)
        }
        else if let dataInfo = data as? NSDictionary
        {
            dataInfo.writeToFile(path, atomically: true)
        }
    }
    
    //UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSongs.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.imageView?.image = listSongs[indexPath.row].thumbnail
        cell.textLabel?.text = "\(listSongs[indexPath.row].title) Ca Sỹ: \(listSongs[indexPath.row].artistName)"
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let audioPlay = AudioPlayer.sharedInstance
        audioPlay.pathString = listSongs[indexPath.row].sourceOnline
        audioPlay.titleSong = listSongs[indexPath.row].title + "(\(listSongs[indexPath.row].artistName))"
        audioPlay.setupAudio()
        NSNotificationCenter.defaultCenter().postNotificationName("setupObserverAudio", object: nil)
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .Normal, title: "Download") { action, index in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                self.downloadSong(indexPath.row)
            })
            
            self.myTableView.reloadData()
        }
        edit.backgroundColor = UIColor(red: 248/255, green: 55/255, blue: 186/255, alpha: 1.0)
        return [edit]
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0;
    }
}

