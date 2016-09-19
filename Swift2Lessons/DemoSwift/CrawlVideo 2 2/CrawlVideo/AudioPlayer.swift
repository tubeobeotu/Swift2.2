//
//  ViewController.swift
//  Music Player
//
//  Created by VietHung on 5/27/16.
//  Copyright © 2016 VietHung. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: NSObject{
    class var sharedInstance: AudioPlayer
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AudioPlayer? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AudioPlayer()
        }
        return Static.instance!
    }
    var pathString = ""
    var repeating = false
    var playing = false
    var duration = Float()
    var currentTime = Float()
    var titleSong = ""
    var player = AVPlayer()


    func setupAudio()
    {
        var url = NSURL()
        if let checkingUrl = NSURL(string: pathString)
        {
            url = checkingUrl
        }
        else
        {
            url = NSURL(fileURLWithPath: pathString)
        }
        let playerItem = AVPlayerItem(URL:url)
        player = AVPlayer(playerItem:playerItem)
        player.rate = 1.0;
        player.volume = 0.5
        player.play()
        playing = true
        repeating = true
    }
    
    
    //action
    func Repeat(repeatSong: Bool) {
        if(repeatSong == true){
            repeating = true
        }
        else{
            repeating = false
        }
    }
    
    func action_PlayPause() {
        if(playing == false){
            player.play()
            playing = true
        }
        else{
            player.pause()
            playing = false
        }
    }
    func sld_Duration(value: Float) {
        let timeToSeek = value * duration
        let time = CMTimeMake(Int64(timeToSeek), 1)
        player.seekToTime(time)
    }
    
    func sld_Volume(value: Float) {
        player.volume = value
    }
    
    
    
    
    
}

