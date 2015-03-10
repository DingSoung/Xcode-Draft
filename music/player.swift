//
//  livePlayer.swift
//  music
//
//  Created by 丁松 on 15/3/10.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation


class player: UIViewController {
    var livePlayer = MPMoviePlayerController()
    var localplayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var url = //"/Users/Soung/Desktop/" + "test.mp3"
        "http://www.itinge.com/music/3/9158.mp3"
        //"https://mtc.cdn.vine.co/r/videos/55E9B17281990629401697910784_1d8613ad683.3.1_jqxCCdF_bYEX05o4k7Pi24VMJbVJmPLJAZZR1LAtk9Xz_Qwf3G5m8c1ggKDdJAaW.mp4?versionId=6pLpbrMHhP2yPXDq.nboJfDbZjXQR3zA"
        livePlay(url)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func livePlay(url:String) {
        self.livePlayer.prepareToPlay()
        self.livePlayer.movieSourceType = MPMovieSourceType.Streaming
        self.livePlayer.contentURL = NSURL(string: url)
        self.livePlayer.controlStyle = MPMovieControlStyle./*Embedded*/None
        self.livePlayer.scalingMode = MPMovieScalingMode.AspectFill
        self.livePlayer.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 240))
        //self.view.addSubview(livePlayer.view)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "livePlayerDidChangeState:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: livePlayer)
        
        self.livePlayer.play()
    }
    func livePlayerDidChangeState(note: NSNotification) {
        let playbackState = self.livePlayer.playbackState
        println("[moviePlayerDidChangeState]playbackState = \(playbackState.rawValue)")
        
        let isReplayAvailable = playbackState == .Stopped || playbackState == .Paused || playbackState == .Interrupted
        if isReplayAvailable {
            if note.object as MPMoviePlayerController == self.livePlayer {
                //                let reason = note.userInfo(objectForKey: MPMoviePlayerPlaybackDidFinishReasonUserInfoKey).integerValue
                //                if reason == MPMovieFinishReasonPlaybackEnded {
                //                    self.moviePlayer.play()
                //                }
            }
        }
    }
    
    
    func localPlay(url:String) {
        localplayer = AVAudioPlayer()
        var errMsg = NSErrorPointer()
        self.localplayer = AVAudioPlayer(contentsOfURL: NSURL(string: url), error: errMsg)
        self.localplayer.volume = 0.2
        self.localplayer.prepareToPlay()
        self.localplayer.play()
    }
    
    
    
    
    
    
    
    
    /*
    
    func startPlayer(url:String) {
        if(self.player == nil) {
            return
        }
         self.player.play()
    }
    func pausePlayer() {
        if(self.player == nil) {
            return
        }
        if(self.player.playing){
            player.pause()
        }
    }
    func stopPlayer(){
        if(self.player == nil) {
            return
        }
        self.player.stop()
    }
*/
    
    
    
    

    
}

