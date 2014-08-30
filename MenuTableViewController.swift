//
//  MenuTableViewController.swift
//  ThumbsOnTheRun
//
//  Created by 丁松 on 14-8-30.
//  Copyright (c) 2014年 丁松. All rights reserved.
//
import UIKit

protocol MenuTableViewControllerDelegate {
    func menuControllerDidSelectRow(indexPath:NSIndexPath)
}

class MenuTableViewController: UITableViewController {
    
    var delegate : MenuTableViewControllerDelegate?
    var tableData : Array<String> = []
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        cell!.textLabel.text = tableData[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        delegate?.menuControllerDidSelectRow(indexPath)
    }
}
