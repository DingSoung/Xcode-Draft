//
//  multiMedia.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-9-9.
//  Copyright (c) 2014年 丁松. All rights reserved.

import UIKit
import AVFoundation

/*
class simplePlayer {
    
    var player:AVAudioPlayer?
    init(url: String, type: String) {   //构造
        switch type {
        case "local":
            var errMsg = NSErrorPointer()
            self.player = AVAudioPlayer(contentsOfURL: NSURL(string: url), error: errMsg)
            self.player.volume = 0.2
            self.player.prepareToPlay()
            //player.delegate = self
        default:
            player = nil
        }
    }
    deinit{   //析构， 释放资源
        player = nil
    }
    
    
    
    func startPlayer(url:String) {
        if(player == nil) {
            return
        }
        player.play()
    }
    func pausePlayer() {
        if(player == nil) {
            return
        }
        if(player.playing){
            player.pause()
        }
    }
    func stopPlayer(){
        if(player == nil) {
            return
        }
        player.stop()
    }
}

*/


