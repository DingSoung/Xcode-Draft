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
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //页面统计
        if let pageName = self.title {
            MobClick.beginLogPageView(pageName)
        } else {
            MobClick.beginLogPageView(NSStringFromClass(object_getClass(self)))
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        //页面统计
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

    @IBAction func weChatAction(sender: UIButton) {
        UMSocialData.defaultData().extConfig.wechatSessionData.url = "http://baidu.com"
        UMSocialData.defaultData().extConfig.wechatSessionData.title = "微信好友title"
        UMSocialData.defaultData().extConfig.wxMessageType = UMSocialWXMessageTypeImage;
        
        let model = UMSocialShareModel()
        model.snstype = UMSocialSnsTypeWechatSession
        UMSocialManager.instance.share(model, presentedController: self, success: { (data) -> Void in
            print(data)
            }) { (error) -> Void in
                print(error.domain)
        }
    }
    
    @IBAction func weiboAction(sender: UIButton) {
        let model = UMSocialShareModel()
        model.snstype = UMSocialSnsTypeSina
        UMSocialManager.instance.share(model, presentedController: self, success: { (data) -> Void in
            print(data)
            }) { (error) -> Void in
                print(error.domain)
        }
    }
    
    @IBAction func qqAction(sender: UIButton) {
        UMSocialData.defaultData().extConfig.qqData.url = "http://baidu.com";
        UMSocialData.defaultData().extConfig.qzoneData.url = "http://baidu.com";
        UMSocialData.defaultData().extConfig.qqData.title = "QQ分享title";
        UMSocialData.defaultData().extConfig.qzoneData.title = "Qzone分享title";
        UMSocialData.defaultData().extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
        
        let model = UMSocialShareModel()
        model.snstype = UMSocialSnsTypeMobileQQ
        UMSocialManager.instance.share(model, presentedController: self, success: { (data) -> Void in
            print(data)
            }) { (error) -> Void in
                print(error.domain)
        }
    }
}






