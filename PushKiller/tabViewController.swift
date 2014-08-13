//
//  tabViewController.swift
//  PushKiller
//
//  Created by 丁松 on 14-8-12.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
//主选项视图控制器调用了主视图控制器和设置视图控制器
class tabViewController:UITabBarController {
//    需要传参数并初始化就用init，否则就用默认的
//        init(coder aDecoder: NSCoder!) {
//            super.init(coder: aDecoder)
//            println("init coder")
//        }
//    
//        init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
//            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//            println("init name")
//        }
//    在这个累的条件下进一步配置界面
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewSetting = settingViewController()
        viewSetting.title = "设置"
        var viewMessage = messageViewController()
        viewMessage.title = "消息回"
        var Setting = UINavigationController(rootViewController:viewSetting)
        var Message = UINavigationController(rootViewController:viewMessage)
        self.viewControllers = [Setting, Message]
        self.selectedIndex = 0
    }
}