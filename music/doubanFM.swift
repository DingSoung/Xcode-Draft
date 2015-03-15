//
//  multiMedia.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-9-9.
//  Copyright (c) 2014年 丁松. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON


class doubanFM: UIViewController, UITableViewDelegate, UITableViewDataSource,MPMoviePlayerDelegate {    //4
    
    func didGetPlayCommand(){   //5
        //do some thing
    }
    
    var doubanPlayer = MPMoviePlayerViewController()
    
    
    
    
    
    var resourceData:JSON = nil
    let chchePath = NSHomeDirectory() as String + "/tmp/"
    @IBOutlet weak var sourceTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doubanPlayer.delegate = self    //6
        
        
        
        //self.sourceTable.dataSource = self
        //self.sourceTable.delegate = self
        //self.getChannelList()
        //self.getPlayList("1")
    }
    
    

    @IBAction func radioStationButton(sender: AnyObject) {
        
        
        
        self.getChannelList()
        
        doubanPlayer.playList() //7
    }
    
    

    
    //on line resource
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
                self.sourceTable.reloadData()
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
            self.sourceTable.reloadData()
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
                var picUrl = self.chchePath + "picture\(indexPath.row).jpg"
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
            //self.delegate?.updatePlayer("test")  //self.resourceData["channels"][indexPath.row]["channel_id"].string!
            
            //let channel_id:String="22"
            //self.delegate?.onChnnel(channel_id)
            
            //self.delegate.changeLabel()
            
            self.dismissMoviePlayerViewControllerAnimated()
        }
    }
}





