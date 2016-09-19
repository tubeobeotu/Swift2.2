//
//  DataBase.swift
//  SQLITE_MUSIC
//
//  Created by Tuuu on 7/22/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation

class DataBase{
    var dataBasePath = NSString()
    init()
    {
        getPath()
        if (createDataBase() == true)
        {
            insertNewValuesToTables()
        }
        
    }
    func insertNewValuesToTables()
    {
        //ALBUMS
        
        insertDatabase("ALBUMS", dict: ["Price":"200.000", "AlbumName":"Anh Bỏ Thuốc Em Sẽ Yêu", "ReleaseDate":"11/1/2015", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu - Lyna Thùy Linh.jpg"])
        insertDatabase("ALBUMS", dict: ["Price":"350.000", "AlbumName":"Anh Cứ Đi Đi", "ReleaseDate":"3/4/2015", "UrlImg":"Anh Cứ Đi Đi.jpg"])
        insertDatabase("ALBUMS", dict: ["Price":"400.000", "AlbumName":"Bí Mật Bị Thời Gian Vùi Lấp", "ReleaseDate":"6/9/2015", "UrlImg":"Bí Mật Bị Thời Gian Vùi Lấp.jpg"])
        insertDatabase("ALBUMS", dict: ["Price":"700.000", "AlbumName":"Đếm Ngày Xa Em - Lou Hoàng,OnlyC", "ReleaseDate":"30/1/2014", "UrlImg":"Đếm Ngày Xa Em - Lou Hoàng,OnlyC.jpg"])
        insertDatabase("ALBUMS", dict: ["Price":"150.000", "AlbumName":"Yêu Một Người Không Sai", "ReleaseDate":"19/5/2016", "UrlImg":"Yêu Một Người Không Sai.jpg"])
        
        //ARTISTS
        insertDatabase("ARTISTS", dict: ["ArtistName":"Chí Thiện", "Born":"19/5/1986", "UrlImg":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST).jpg"])
        insertDatabase("ARTISTS", dict: ["ArtistName":"HariWon", "Born":"20/11/1983", "UrlImg":"Anh Cứ Đi Đi - Hari Won.jpg"])
        insertDatabase("ARTISTS", dict: ["ArtistName":"LOU HOÀNG", "Born":"19/1/1990", "UrlImg":"LOUHOANG.jpg"])
        insertDatabase("ARTISTS", dict: ["ArtistName":"LYNA THUỲ LINH", "Born":"27/8/1992", "UrlImg":"LYNA THÙY LINH.jpg"])
        insertDatabase("ARTISTS", dict: ["ArtistName":"MAI FIN", "Born":"19/5/1993", "UrlImg":"Chủ Nhật Buồn .jpg"])
        //Genres
        insertDatabase("GENRES", dict: ["GenreName":"Nhạc Trẻ"])
        insertDatabase("GENRES", dict: ["GenreName":"Trữ Tình"])
        
        //PlayList
        insertDatabase("PLAYLIST", dict: ["PlaylistName":"Nhạc Nghe Lúc Buồn"])
        insertDatabase("PLAYLIST", dict: ["PlaylistName":"Nhạc Thất Tình"])
        
        //Song
        insertDatabase("SONGS", dict: ["SongName":"Anh Bỏ Thuốc Em Sẽ Yêu", "UrlImg":"Anh Bỏ Thuốc Em Sẽ Yêu.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Gái Nhà Lành", "UrlImg":"Gái Nhà Lành.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Anh Cứ Đi Đi", "UrlImg":"Anh Cứ Đi Đi - Hari Won.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Điệp Khúc Mùa Xuân - Sơn Ngọc Minh, Hari Won", "UrlImg":"Điệp Khúc Mùa Xuân.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Chỉ Mong Trái Tim Người", "UrlImg":"Chỉ Mong Trái Tim Người.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST)", "UrlImg":"Tình Yêu Nhạt Màu (Bí Mật Bị Thời Gian Vùi Lấp OST).jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Đếm Ngày Xa Em", "UrlImg":"Đếm Ngày Xa Em.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Yêu Một Người Có Lẽ", "UrlImg":"Yêu Một Người Có Lẽ.jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Chủ Nhật Buồn", "UrlImg":"Chủ Nhật Buồn .jpg"])
        insertDatabase("SONGS", dict: ["SongName":"Yêu Một Người Không Sai", "UrlImg":"Yêu Một Người Không Sai.jpg"])
        
        //DetailPlaylist
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"1", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"2", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"3", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"4", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"5", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"6", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"7", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"8", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"9", "PlayListID":"1"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"10", "PlayListID":"1"])
        
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"6", "PlayListID":"2"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"7", "PlayListID":"2"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"8", "PlayListID":"2"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"9", "PlayListID":"2"])
        insertDatabase("DETAILPLAYLIST", dict: ["SongID":"10", "PlayListID":"2"])
        
        //DetailAlbum
        
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"1", "GenreID":"1", "ArtistID":"4", "SongID":"1"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"1", "GenreID":"1", "ArtistID":"4", "SongID":"2"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"2", "GenreID":"1", "ArtistID":"2", "SongID":"3"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"2", "GenreID":"1", "ArtistID":"2", "SongID":"4"])
        
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"3", "GenreID":"1", "ArtistID":"5", "SongID":"5"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"3", "GenreID":"1", "ArtistID":"5", "SongID":"6"])
        
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"4", "GenreID":"1", "ArtistID":"3", "SongID":"7"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"4", "GenreID":"1", "ArtistID":"3", "SongID":"8"])
        
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"5", "GenreID":"1", "ArtistID":"1", "SongID":"9"])
        insertDatabase("DETAILALBUM", dict: ["AlbumID":"5", "GenreID":"1", "ArtistID":"1", "SongID":"10"])
    }
    func getPath()
    {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = NSString(string: dirPaths[0])
        dataBasePath = docsDir.stringByAppendingPathComponent("musics.db")
    }
    func createDataBase() -> Bool
    {
        let file = NSFileManager.defaultManager()
        //kiểm tra xem file database đã có hay chưa
        if(!file.fileExistsAtPath(dataBasePath as String))
        {
            //khởi tạo Database với đường dẫn
            let musicsDB = FMDatabase(path: dataBasePath as String)
            if musicsDB == nil
            {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            if musicsDB.open()
            {
                //các câu lệnh tạo table
                let sql_Create_SONGS = "create table if not exists SONGS (ID integer primary key autoincrement, SongName text, UrlImg text)"
                let sql_Create_DetailPlayList = "create table if not exists DetailPlayList (SongID integer, PlayListID integer, foreign key (PlayListID) references PLAYLIST(ID), foreign key (SongID) references SONG(ID), primary key (SongID, PlayListID))"
                let sql_Create_PlayList = "create table if not exists PLAYLIST (ID integer primary key autoincrement, PlaylistName text)"
                let sql_Create_ALBUMS = "create table if not exists ALBUMS (ID integer primary key autoincrement, Price text, AlbumName text, ReleaseDate text, UrlImg text)"
                
                let sql_Create_DetailAlbum = "create table if not exists DETAILALBUM (AlbumID integer, GenreID integer, ArtistID integer, SongID integer, foreign key (AlbumID) references ALBUMS(ID), foreign key (GenreID) references GENRES(ID), foreign key (ArtistID) references ARTISTS(ID), foreign key (SongID) references SONGS(ID), primary key (AlbumID, GenreID, ArtistID, SongID))"
                
                let sql_Create_ARTISTS = "create table if not exists ARTISTS (ID integer primary key autoincrement, ArtistName text, UrlImg text, Born text not null)"
                
                let sql_Create_GENRES = "create table if not exists GENRES (ID integer primary key autoincrement, GenreName text)"
                
                //tạo table
                if !musicsDB.executeStatements(sql_Create_SONGS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_DetailPlayList) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_PlayList) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_ALBUMS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_DetailAlbum) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_ARTISTS) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
                if !musicsDB.executeStatements(sql_Create_GENRES) {
                    print("Error: \(musicsDB.lastErrorMessage())")
                }
            }
            else
            {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            musicsDB.open()
            return true
        }
        return false
    }
    func insertDatabase(nameTable: String, dict: NSDictionary)
    {
        //tạo các biến chứa keys và values để chèn vào table
        var keys = String()
        var values = String()
        var first = true
        for key in dict.allKeys
        {
            if (first == true)
            {
                keys = "'" + (key as! String) + "'"
                values = "'" + (dict.objectForKey(key) as! String) + "'"
                first = false
                continue
            }
            //duyệt qua tất cả các phần tử và cộng vào biết keys và values
            keys = keys + "," + "'" + (key as! String) + "'"
            values = values + "," + "'" + (dict.objectForKey(key) as! String) + "'"
        }
        let musicsDB = FMDatabase(path: dataBasePath as String)
        if musicsDB == nil
        {
            print("Error: \(musicsDB.lastErrorMessage())")
        }
        if musicsDB.open()
        {
            if (!musicsDB.executeStatements("PRAGMA foreign_keys = ON"))
            {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            //chèn values và keys vào table
            let insertSQL = "INSERT INTO \(nameTable) (\(keys)) VALUES (\(values))"
            let result = musicsDB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            if !result
            {
                print("Error: \(musicsDB.lastErrorMessage())")
            }
            
        }
        musicsDB.close()
    }
    
    func viewDataBase(tableName:String, columns:[String], statement: String) -> [NSDictionary]
    {
        var items = [NSDictionary]()
        let musicsDB = FMDatabase(path: dataBasePath as String)
        if musicsDB == nil
        {
            print("Error: \(musicsDB.lastErrorMessage())")
        }
        if musicsDB.open()
        {
            ["name", "id"]
            var allColumns = ""
            for column in columns
            {
                //giống như hàm insert
                if (allColumns == "")
                {
                    allColumns = column
                }
                else
                {
                    allColumns = allColumns + "," + column
                }
            }
            //câu lệnh query
            let querySQL = "Select DISTINCT \(allColumns) From \(tableName) \(statement)"
            let results: FMResultSet? = musicsDB.executeQuery(querySQL, withArgumentsInArray: nil)
            //results.next có nghĩa là có bản ghi tiếp theo đâu
            while ((results?.next()) == true) {
                items.append((results?.resultDictionary())!)
            }
        }
        musicsDB.close()
        return items
    }
    
    

}