//
//  messageViewController.swift
//  PushKiller
//
//  Created by 丁松 on 14-8-12.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit
class messageViewController:UITableView {
    
    
    func clearMessageStack() {
        let alertView = UIAlertView()
        alertView.title = "清空消息"
        alertView.message = "确认清空消息吗?"
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("清空")
        alertView.show()
        alertView.delegate = self
    }
}

