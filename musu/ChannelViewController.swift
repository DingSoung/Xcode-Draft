//
//  ChannelViewController.swift
//  musu
//
//  Created by 丁松 on 15/3/20.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
import CoreData

class ChannelViewController: UITableViewController {
    
    //var Channels = [String]()
    var Channels = NSArray()
    
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
    
    @IBAction func refreashChannelButton(sender: AnyObject) {
        downloadData("http://www.douban.com/j/app/radio/channels", dataHandler: {
            (data:NSData) -> Void in
            //以字典的形式读取，只有1个元素  要么是channel 要么是song, 然后把它下面的东西转换成数组
            var objects = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            if(objects["channels"] != nil) {
                self.Channels = objects["channels"] as NSArray
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func addChannelButton(sender: AnyObject) {
        let alert = UIAlertController(title: "Add Channel", message: "fill info for the channel", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField!) -> Void in }
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField!) -> Void in }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            let name = alert.textFields![0] as UITextField
            let channel_id = alert.textFields![1] as UITextField
            
            //self.Channels.append(textfield.text)
            //self.addChannel(name.text, key: "name")
            //self.addAttribute(channel_id.text, key: "channel_id")
            
            //self.tableView.reloadData()
            let indexPath = NSIndexPath(forRow: (self.Channels.count - 1), inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .Default, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancleAction)
        
        self.presentViewController(alert, animated: true) { () -> Void in
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Channel"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //reloadCoreData()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SendPlayList" {  //在storyboard的segue的属性中设置
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = Channels[indexPath.row] as NSDictionary
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
        }
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        //return 0
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return 0
        return Channels.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let cellIdentifer = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        // Configure the cell...
        let rawData: NSDictionary = self.Channels[indexPath.row] as NSDictionary
        if(rawData["name"] != nil) {
            cell?.textLabel?.text = rawData["name"] as? String
            cell?.imageView?.image = UIImage(named: "playlists.png")
        }
        return cell!
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            var tempArray:NSMutableArray = Channels as NSMutableArray
            tempArray.removeObjectAtIndex(indexPath.row)
            Channels = tempArray as NSArray
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
