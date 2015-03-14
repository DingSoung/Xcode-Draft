//
//  multiMedia.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-9-9.
//  Copyright (c) 2014年 丁松. All rights reserved.

import UIKit
import MediaPlayer
import Alamofire

class MPMoviePlayerViewController: UIViewController, ChannelProtocol{
    
    var testChannel = doubanFM()
    
    var MPMoviePlayer: MPMoviePlayerController!
    let filePath = NSHomeDirectory() as String + "/tmp/"
    var timer:NSTimer!
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var progressLabel: LTMorphingLabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        testChannel.delegate = self
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func testDelegatedClassfnc(sender: AnyObject) {
        
        testChannel.testDelegateeee()
        
    }
    
    
    
    
    //for protocol
    func updatePlayer(musicUrl:String) {
        //self.startPlayer(musicUrl)
        self.stopPlayer()
    }
    func changeLabel(){
        //self.label!.text=newString
    }
    func onChnnel(channels_ur: String) {
        var url:String="http://douban.fm/j/mine/playlist?channel=\(channels_ur)"
    }
    
    
    //for view controller
    @IBAction func playPauseButton(sender: AnyObject) {
        togglePlayer()
    }
    
    func startPlayer(url:String) {
        //for delInit & config source
        self.MPMoviePlayer = MPMoviePlayerController()
        self.MPMoviePlayer.contentURL = NSURL(string: url)
        self.MPMoviePlayer.prepareToPlay()
        //self.MPMoviePlayer.movieSourceType = MPMovieSourceType.Streaming
        
        //for display
        if (self.MPMoviePlayer.movieMediaTypes == MPMovieMediaTypeMask.Video) {
            self.MPMoviePlayer.view.frame = CGRect(origin: CGPoint(x: 0, y: self.view.frame.size.height - 180), size: CGSize(width: self.view.frame.size.width, height: 180))
            self.view.addSubview(self.MPMoviePlayer.view)
            self.MPMoviePlayer.backgroundView.backgroundColor = UIColor.redColor()
            self.MPMoviePlayer.controlStyle = MPMovieControlStyle.Embedded
            self.MPMoviePlayer.scalingMode = .AspectFit // defaul
        }
        
        //for playback control
        self.MPMoviePlayer.initialPlaybackTime = 0
        // self.MPMoviePlayer.endPlaybackTime = 20
        // self.MPMoviePlayer.currentPlaybackRate
        // self.MPMoviePlayer.currentPlaybackTime
        // self.MPMoviePlayer.shouldAutoplay = true    // default true
        
        //for Notification
        //        MPMoviePlayerReadyForDisplayDidChangeNotification
        //        MPMoviePlayerPlaybackStateDidChangeNotification
        //        MPMovieNaturalSizeAvailableNotification
        //        MPMoviePlayerLoadStateDidChangeNotification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "livePlayerChangeStateHandel:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: self.MPMoviePlayer)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("timerHandel:"), userInfo: nil,repeats: true)
        
        self.MPMoviePlayer.play()
    }
    func livePlayerChangeStateHandel(note: NSNotification) {
        println("playbackState \(self.MPMoviePlayer.playbackState)")
        switch self.MPMoviePlayer.playbackState {
        case MPMoviePlaybackState.Playing:
            self.playPauseButton.setImage(UIImage(named:"pause.png"), forState : UIControlState.Normal)
        case MPMoviePlaybackState.Paused:
            self.playPauseButton.setImage(UIImage(named:"play.png"), forState : UIControlState.Normal)
        case MPMoviePlaybackState.Stopped:
            self.playPauseButton.setImage(UIImage(named:"stop.png"), forState : UIControlState.Normal)
        default:
            self.playPauseButton.setImage(UIImage(named:"stop.png"), forState : UIControlState.Normal)
        }
    }
    func timerHandel(timer: NSTimer){
        if(MPMoviePlayer.playbackState != MPMoviePlaybackState.Playing){
            return
        }
        var minute_ = abs(Int((self.MPMoviePlayer.currentPlaybackTime/60) % 60))
        var second_ = abs(Int(self.MPMoviePlayer.currentPlaybackTime % 60))
        var minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        var second = second_ > 9 ? "\(second_)" : "0\(second_)"
        self.progressLabel.text  = "\(minute):\(second)"
    }
    
    func stopPlayer() {
        if(self.MPMoviePlayer == nil) {
            return
        }
        self.MPMoviePlayer.stop()
        timer.invalidate()
    }
    func togglePlayer() {
        if(self.MPMoviePlayer == nil) {
            return
        }
        if(self.MPMoviePlayer.playbackState == MPMoviePlaybackState.Playing) {
            self.MPMoviePlayer.pause()
        } else {
            self.MPMoviePlayer.play()
        }
    }
    
    
    
    
    
    
    
    func downloadData(url: String, dataHandler:(NSData) -> Void){
        var request = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var httpResponse = response as NSHTTPURLResponse
            if(httpResponse.statusCode == 200){
                dataHandler(data)
            }
            else {
                println(httpResponse)
            }
        })
    }
    func playOnlineMusic(url:String){
        if (url.hasPrefix("http") == true) {
            downloadData(url, dataHandler: {
                (data:NSData) -> Void in
                var musicUrl = self.filePath + "test" + ".mp3"
                data.writeToFile(musicUrl, atomically: true)
                self.startPlayer(musicUrl)
            })
        }
    }

}





