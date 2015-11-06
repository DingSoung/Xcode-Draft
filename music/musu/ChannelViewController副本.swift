//
//  SecondViewController.swift
//  musu
//
//  Created by 丁松 on 15/3/15.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
class ChannelViewController: UITableViewController {
    let tmpPath = NSHomeDirectory() as String + "/tmp/"
    var screenEdgeRecognizer: UIScreenEdgePanGestureRecognizer!
    
    var objects: NSDictionary!
    var SelectObjectIndex: Int!
    var tableArray: NSArray = NSArray()
    var Channels = [String]()
    var imageCache = Dictionary<String ,UIImage>()
    var musicPlayer = PlayerViewController()
    //on line resource
    
    
    
    
    @IBAction func addChannel(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Channel", message: "fill info for the channel", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField!) -> Void in
            //
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            //self.Channels.append(<#newElement: T#>)
            let textfield = alert.textFields![0] as UITextField
            self.Channels.append(textfield.text)
            self.tableView.reloadData()
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .Default, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancleAction)
        
        self.presentViewController(alert, animated: true) { () -> Void in
            //
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
    func getJSON(url:String){
        downloadData(url, dataHandler: {
            (data:NSData) -> Void in
            self.objects = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            //以字典的形式读取，只有1个元素  要么是channel 要么是song, 然后把它下面的东西转换成数组
            if(self.objects["channels"] != nil) {
                self.tableArray = self.objects["channels"] as NSArray
            } else if(self.objects["song"] != nil) {
                self.tableArray = self.objects["song"] as NSArray
            }
            self.tableView.reloadData()
            //println("table conten = \(self.tableArray)")
            //println("table length = \(self.tableArray.count)")
        })
    }
    
    //
    //    var detailViewController: DetailViewController? = nil
    //    var objectssssssss = [AnyObject]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.getJSON("http://www.douban.com/j/app/radio/channels")
        
        //左侧边缘滑动手势识别
        screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self,action: "EdgeSwipeLeftHandel:")
        screenEdgeRecognizer.edges = .Left
        view.addGestureRecognizer(screenEdgeRecognizer)
        
        
        
        //添加默认按键 删除
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        //添加增添按键 添加
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
        //        if let split = self.splitViewController {
        //            let controllers = split.viewControllers
        //            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        //        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func EdgeSwipeLeftHandel(sender: UIScreenEdgePanGestureRecognizer) {
        self.getJSON("http://www.douban.com/j/app/radio/channels")
    }
    func insertNewObject(sender: AnyObject) {
        var tempArray:NSMutableArray = self.tableArray as NSMutableArray
        var Objec2Insert: AnyObject = tempArray[0]
        tempArray.insertObject(Objec2Insert, atIndex: 0)
        self.tableArray = tempArray as NSArray
        self.tableView.reloadData()
    }
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SendPlayList" {  //在storyboard的segue的属性中设置
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.tableArray[indexPath.row] as NSDictionary
                var PlayListUrl = "http://douban.fm/j/mine/playlist?channel=" + (object["channel_id"] as String)
                    downloadData(PlayListUrl, dataHandler: {
                        (data:NSData) -> Void in
                        var tempObjects = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                        
                        if(tempObjects["song"] != nil) {
                            var destViewController = segue.destinationViewController as PlayListViewController;
                            destViewController.receiveData = tempObjects["song"] as? NSArray
                        }
                    })
                
            }
            //                    if let indexPath = self.tableView.indexPathForSelectedRow() {
            //
            //                        let object = self.tableArray[indexPath.row] as NSDate
            //
            //                        let destViewController = segue.destinationViewController as DetailViewController
            //                        destViewController.detailItem = object //生效
            //
            //                        //destViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            //                        //destViewController.navigationItem.leftItemsSupplementBackButton = true //显示返回
            //                    }
        }
        
    }
    
    
    //tableview delegate
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.SelectObjectIndex = indexPath.row
        //        let rawData: NSDictionary = self.tableArray[indexPath.row] as NSDictionary
        //        if (rawData["channel_id"] != nil) {
        //            getJSON("http://douban.fm/j/mine/playlist?channel=" + (rawData["channel_id"] as String))
        //        } else if (rawData["url"] != nil) {
        //            self.musicPlayer.startPlayer(rawData["url"] as String)
        //        }
    }
    //tableview datadource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.tableArray.count
        return Channels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifer = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        //取出数组下的某一个，转换成字典，然后读取对应的值
        cell?.textLabel?.text = Channels[indexPath.row]
        
//        let rawData: NSDictionary = self.tableArray[indexPath.row] as NSDictionary
//        if(rawData["name"] != nil) {
//            cell?.textLabel?.text = rawData["name"] as? String
//            cell?.imageView?.image = UIImage(named: "playlists.png")
//        } else if (rawData["title"] != nil) {
//            cell?.textLabel?.text = rawData["title"] as? String
//            //使用沙盒缓存
//            var picUrl = self.tmpPath + "picture\(indexPath.row).jpg"
//            if (UIImage(named :picUrl) == nil) {
//                downloadData(rawData["picture"] as String, dataHandler: {
//                    (data:NSData) -> Void in
//                    data.writeToFile(picUrl, atomically: true)
//                    cell?.imageView?.image = UIImage(named :picUrl)
//                })
//            } else {
//                cell?.imageView?.image = UIImage(named :picUrl)
//            }
//            //写入内存
//            //            let imageUrl = rawData["picture"] as String
//            //            if !(imageCache[imageUrl] != nil) {
//            //                downloadData(rawData["picture"] as String, dataHandler: {
//            //                    (data:NSData) -> Void in
//            //                    let img = UIImage(data: data)
//            //                    cell?.imageView?.image = img
//            //                    self.imageCache[imageUrl] = img
//            //                })
//            //            }
//        }
        return cell!
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //删除或添加元素
        var tempArray:NSMutableArray = self.tableArray as NSMutableArray
        if editingStyle == .Delete {
            tempArray.removeObjectAtIndex(indexPath.row)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
        self.tableArray = tempArray as NSArray
        self.tableView.reloadData()
        return
    }
}