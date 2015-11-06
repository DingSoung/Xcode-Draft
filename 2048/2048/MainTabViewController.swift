//
//  MainViewController.swift
//  2048
//
//  Created by 丁松 on 14-6-15.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

//主选项视图控制器调用了主视图控制器和设置视图控制器
class MainTabViewController:UITabBarController
{
    init(){
        super.init(nibName:nil, bundle:nil)
        
        var viewMain = MainViewController()
        viewMain.title = "2048"
        var viewSetting = SettingViewController()
        viewSetting.title = "设置"
                var mian = UINavigationController(rootViewController:viewMain)
        var setting = UINavigationController(rootViewController:viewSetting)
        
        self.viewControllers = [mian, setting]
        self.selectedIndex = 0
    }
    
}
