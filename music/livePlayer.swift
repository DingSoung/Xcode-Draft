//
//  multiMedia.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-9-9.
//  Copyright (c) 2014年 丁松. All rights reserved.

import UIKit
import MediaPlayer
import Alamofire
import SwiftyJSON
class livePlayerController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var MPMoviePlayer: MPMoviePlayerController!
    
    //private var fileName = "xiaopingguo.mp3"
    let filePath = NSHomeDirectory() as String + "/tmp/"
    var musicUrl:NSURL!
    var timer:NSTimer!
    var doubanChannel = doubanFM()
    var resourceData:JSON = nil
    
    
    @IBOutlet weak var playList: UITableView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var progressLabel: LTMorphingLabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.progressLabel.morphingEffect = .Evaporate
        //getPlayList("1")
        self.getChannelList()
    }
    override func viewWillAppear(animated: Bool) {
        playList.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func doubanPlayList(playList: JSON) {
        resourceData = playList
        self.playList.reloadData()
    }
    
    @IBAction func playPauseButton(sender: AnyObject) {
        togglePlayer()
    }
    @IBAction func reset2ChannelList(sender: AnyObject) {
        self.getChannelList()
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
            self.playPauseButton.setImage(UIImage(named:"pause-50.png"), forState : UIControlState.Normal)
        case MPMoviePlaybackState.Paused:
            self.playPauseButton.setImage(UIImage(named:"play-50.png"), forState : UIControlState.Normal)
        case MPMoviePlaybackState.Stopped:
            self.playPauseButton.setImage(UIImage(named:"stop-50.png"), forState : UIControlState.Normal)
        default:
            self.playPauseButton.setImage(UIImage(named:"stop-50.png"), forState : UIControlState.Normal)
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
        self.MPMoviePlayer.stop()
        timer.invalidate()
    }
    func togglePlayer() {
        if(self.MPMoviePlayer.playbackState == MPMoviePlaybackState.Playing) {
            self.MPMoviePlayer.pause()
        } else {
            self.MPMoviePlayer.play()
        }
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
    
    //on line resource
    func getChannelList(){
        if(self.resourceData["channels"].count == 0){
            var doubanChannelUrl = "http://www.douban.com/j/app/radio/channels"
            Alamofire.request(.GET, doubanChannelUrl).responseJSON {
                (request, response, data, error) -> Void in
                if(data == nil){
                    println(error)
                    return
                }
                self.resourceData = JSON(data!)
                self.playList.reloadData()
            }
        }
    }
    func getPlayList(channel_id:String){
        var listUrl = "http://douban.fm/j/mine/playlist?channel=" + channel_id
        Alamofire.request(.GET, listUrl).responseJSON {
            (request, response, data, error) -> Void in
            if(data == nil){
                println(error)
                return
            }
            self.resourceData = JSON(data!)
            self.playList.reloadData()
            //println("\(self.resourceData)")
        }
    }
    
    //display playlist
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resourceData["channels"].count > 0){
            return self.resourceData["channels"].count
        }else{
            return self.resourceData["song"].count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifer = "playListCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        if (self.resourceData["channels"].count > 0){
            cell?.textLabel?.text = self.resourceData["channels"][indexPath.row]["name"].string
            cell?.detailTextLabel?.text = self.resourceData["channels"][indexPath.row]["name_en"].string
        }else{
            cell?.textLabel?.text = self.resourceData["song"][indexPath.row]["title"].string
            cell?.detailTextLabel?.text = self.resourceData["song"][indexPath.row]["albumtitle"].string
            downloadData(self.resourceData["song"][indexPath.row]["picture"].string!, dataHandler: {
                (data:NSData) -> Void in
                var picUrl = self.filePath + "picture\(indexPath.row).jpg"
                data.writeToFile(picUrl, atomically: true)
                cell?.imageView?.image = UIImage(named :picUrl)
            })
        }
        return cell!
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.resourceData["channels"].count > 0){
            self.getPlayList(self.resourceData["channels"][indexPath.row]["channel_id"].string!)
        }else{
            self.startPlayer(resourceData["song"][indexPath.row]["url"].string!)
        }
    }
}





