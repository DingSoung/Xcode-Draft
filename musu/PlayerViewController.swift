//
//  FirstViewController.swift
//  musu
//
//  Created by 丁松 on 15/3/15.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayerViewController: UIViewController {
    var receiveData: String? {
        didSet {
            println("获取的数据是\(receiveData)")
            self.startPlayer(receiveData!)
        }
    }
    @IBOutlet weak var TitleButton: UIButton!
    @IBOutlet weak var BackGroundImage: UIImageView!
    
    @IBOutlet weak var PlayPauseButton: UIButton!
    @IBAction func PlayPauseButton(sender: AnyObject) {
        self.togglePlayer()
    }
    @IBOutlet weak var PlayTimeLabel: UILabel!
    @IBAction func ShareToWeChatButton(sender: AnyObject) {
        var req = SendMessageToWXReq()
        req.scene = Int32(WXSceneSession.value)
        req.text = receiveData
        req.bText = true
        WXApi.sendReq(req)
    }
    var MPMoviePlayer: MPMoviePlayerController!
    let filePath = NSHomeDirectory() as String + "/Player/"
    var timer:NSTimer!
    
    
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
                    self.PlayPauseButton.setImage(UIImage(named:"pause.png"), forState : UIControlState.Normal)
                case MPMoviePlaybackState.Paused:
                    self.PlayPauseButton.setImage(UIImage(named:"play.png"), forState : UIControlState.Normal)
                case MPMoviePlaybackState.Stopped:
                    self.PlayPauseButton.setImage(UIImage(named:"stop.png"), forState : UIControlState.Normal)
                default:
                    self.PlayPauseButton.setImage(UIImage(named:"stop.png"), forState : UIControlState.Normal)
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
        self.PlayTimeLabel.text  = "\(minute):\(second)"
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
}

