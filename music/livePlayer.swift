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
    var livePlayer = MPMoviePlayerController()
    
    //private var fileName = "xiaopingguo.mp3"
    let filePath = "/Users/Soung/Desktop/"
    var musicUrl:NSURL!
    var timer:NSTimer!
    var timeEscape:Int32!
    var doubanChannel = doubanFM()
    
    var resourceData:JSON = nil
    
    @IBOutlet weak var nowPlaying: UILabel!
    @IBOutlet weak var modeButtom: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var playList: UITableView!
    @IBOutlet weak var coverImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getPlayList("1")
        self.getChannelList()
        nowPlaying.text = "musicPlayer"
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
    
    
    
    
    
    
    
    
    
    
    
    func livePlay(url:String) {
        if(!url.hasPrefix("http")) {
            return
        }
        livePlayer = MPMoviePlayerController()
        
        self.livePlayer.prepareToPlay()
        self.livePlayer.movieSourceType = MPMovieSourceType.Streaming
        self.livePlayer.contentURL = NSURL(string: url)
        self.livePlayer.controlStyle = MPMovieControlStyle./*Embedded*/None
        self.livePlayer.scalingMode = MPMovieScalingMode.AspectFill
        self.livePlayer.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: 240))
        //self.view.addSubview(livePlayer.view)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "livePlayerDidChangeState:", name: MPMoviePlayerPlaybackStateDidChangeNotification, object: livePlayer)
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
    
    
    
    //player func
    func startPlayer(url:String) {
        self.livePlay(url)
        togglePlayer()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateStatus:"), userInfo: nil,repeats: true)
        self.timeEscape = 0
    }
    
    
    func togglePlayer() {

    }
    func updateStatus(timer: NSTimer){
        if(livePlayer.playbackState != MPMoviePlaybackState.Playing){
            return
        }
        self.timeEscape = self.timeEscape + 1
        var hour_   = abs(Int(self.timeEscape)/3600)
        var minute_ = abs(Int((self.timeEscape/60) % 60))
        var second_ = abs(Int(self.timeEscape % 60))
        var hour = hour_ > 9 ? "\(hour_)" : "0\(hour_)"
        var minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        var second = second_ > 9 ? "\(second_)" : "0\(second_)"
        progressLabel.text  = "\(hour):\(minute):\(second)"
    }
    
    
    
    @IBAction func playButton(sender: UIButton) {
        togglePlayer()
    }
    @IBAction func stopPlayer(sender: AnyObject) {
        self.livePlayer.stop()
        playButton.setTitle("Play", forState: UIControlState.Normal)
        timer.invalidate()
    }
    @IBAction func reset2ChannelList(sender: AnyObject) {
        self.getChannelList()
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
            println("\(self.resourceData)")
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
            //self.playOnlineMusic(playListJSON["song"][indexPath.row]["url"].string!)
            self.startPlayer(resourceData["song"][indexPath.row]["url"].string!)
        }
    }
}





