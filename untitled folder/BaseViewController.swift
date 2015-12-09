//
//  BaseViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "please config title"
        
        //MARK: 停止编辑
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        tapGesture.rac_gestureSignal().subscribeNext({ (obj) -> Void in
            self.view.endEditing(true)
        })
        self.view.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer()
        panGesture.rac_gestureSignal().subscribeNext { (obj) -> Void in
            self.view.endEditing(true)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: 页面统计
        if let pageName = self.title {
            MobClick.beginLogPageView(pageName)
        } else {
            MobClick.beginLogPageView(NSStringFromClass(object_getClass(self)))
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let pageName = self.title {
            MobClick.endLogPageView(pageName)
        } else {
            MobClick.endLogPageView(NSStringFromClass(object_getClass(self)))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
