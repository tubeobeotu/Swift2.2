//
//  Protocol.swift
//  SQLiteSample
//
//  Created by Tuuu on 7/16/16.
//  Copyright © 2016 TuNguyen. All rights reserved.
//

import Foundation
import CoreGraphics
enum Type {
    case SONGS
    case ALBUMS
    case ARTISTS
    case PLAYLIST
    case GENRE
    case CELL
    case NONE
}
@objc protocol SelectItem
{
    optional func selectPlayList(id: Int)
    optional func selectSongsOption(id: Int)
    optional func selectAlbumsOption(id: Int)
    optional func selectArtistsOption(id: Int)
    optional func selectGenre(id: Int)
    optional func selectButtonAddPlayList(id: Int, point: CGPoint)
}