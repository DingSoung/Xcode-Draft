

//
//  DetailViewController.swift
//  ttttt
//
//  Created by 丁松 on 15/3/15.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

import UIKit
//
class testSegueViewController : UIViewController {
    
    var receiveData: AnyObject? {
        didSet {
            println("获取的数据是\(receiveData)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
}

class PlayListViewController: UITableViewController {
    
    var receiveData: NSArray? {
        didSet {
            println("获取的数据是\(receiveData)")
            self.tableArray = receiveData!
            self.tableView.reloadData()
        }
    }
    let tmpPath = NSHomeDirectory() as String + "/tmp/"
    
    var tableArray: NSArray = NSArray()
    //var musicPlayer = PlayerViewController()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "SendMusicInfo" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = self.tableArray[indexPath.row] as NSDictionary
                println("\(object)")
                var destViewController = segue.destinationViewController as PlayerViewController;
                //destViewController.TitleButton.setTitle(object["title"] as? String, forState: UIControlState.Normal)
                destViewController.title = object["title"] as? String
                destViewController.receiveData = object["url"] as? String
				
                downloadData(object["picture"] as String, dataHandler: {
                    (data:NSData) -> Void in
                    var BackGroundImageUrl = self.tmpPath + "BackGroundImageUrl.jpg"
                    data.writeToFile(BackGroundImageUrl, atomically: true)
                    destViewController.BackGroundImage.image = UIImage(named :BackGroundImageUrl)
                })
				
				
				
            }
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
//        let rawData: NSDictionary = self.tableArray[indexPath.row] as NSDictionary
//        if (rawData["url"] != nil) {
//            self.musicPlayer.startPlayer(rawData["url"] as String)
//        }
    }
    //tableview datadource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableArray.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifer = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer, forIndexPath: indexPath) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        let rawData: NSDictionary = self.tableArray[indexPath.row] as NSDictionary
        if (rawData["title"] != nil) {
            cell?.textLabel?.text = rawData["title"] as? String
            //使用沙盒缓存
            var picUrl = self.tmpPath + "picture\(indexPath.row).jpg"
            if (UIImage(named :picUrl) == nil) {
                downloadData(rawData["picture"] as String, dataHandler: {
                    (data:NSData) -> Void in
                    data.writeToFile(picUrl, atomically: true)
                    cell?.imageView?.image = UIImage(named :picUrl)
                })
            } else {
                cell?.imageView?.image = UIImage(named :picUrl)
            }
        }
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
        
        if editingStyle == .Delete {
            var tempArray:NSMutableArray = tableArray as NSMutableArray
            tempArray.removeObjectAtIndex(indexPath.row)
            tableArray = tempArray as NSArray
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {}
        return
    }
}

