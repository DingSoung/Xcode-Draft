//
//  UMSocialManager.swift
//  Autumn
//
//  Created by Alex D. on 15/9/23.
//  Copyright © 2015年 Alex D. All rights reserved.
//

import UIKit

class UMSocialShareModel:NSObject {
    var snstype:UMSocialSnsType = UMSocialSnsTypeNone
    var content = ""
    var image:UIImage?
    var location:CLLocation?
    var urlSource:UMSocialUrlResource?
    
}

class UMSocialManager: NSObject {
    static let instance = UMSocialManager()
    private override init() {
        super.init()
        
        UMSocialData.setAppKey("55f93b13e0f55a3ced002115")
        
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret: "db426a9829e4b49a0dcac7b4162da6b6", url: "http://www.umeng.com/social")
        UMSocialQQHandler.setQQWithAppId("100424468", appKey: "c7394704798a158208a74ab60104f0ba", url: "http://www.umeng.com/social")
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
    }
    
    internal func authorize(presentingController:UIViewController,socialPlatform:String, success:(account:UMSocialAccountEntity)->Void, fail:(error:NSError)->Void) {
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(socialPlatform)
        snsPlatform.loginClickHandler(presentingController,UMSocialControllerService.defaultControllerService(),true, {(response:UMSocialResponseEntity!) in
            if response.responseCode == UMSResponseCodeSuccess {
                if let snsAccount = (UMSocialAccountManager.socialAccountDictionary() as NSDictionary).valueForKey(socialPlatform) as? UMSocialAccountEntity {
                    success(account: snsAccount)
                } else {
                    fail(error: NSError(domain: "UMSocialAccountEntity解析错误", code: -1, userInfo: ["data":response]))
                }
            } else {
                fail(error: NSError(domain: "UMSocialResponseEntity解析错误", code: -1, userInfo: ["data":response]))
            }
        })
    }
    
    internal func requestWechatInfo(socoalPlatform:String) {
        UMSocialDataService.defaultDataService().requestSnsInformation(socoalPlatform) { (response: UMSocialResponseEntity!) -> Void in
            print(response.data)
        }
    }
    
    internal func share(model:UMSocialShareModel, presentedController:UIViewController, success:((data:NSDictionary)->Void)?, fail:((error:NSError)->Void)?) -> Void {
        UMSocialManager.instance
        
        var snsType = ""
        switch model.snstype {
        case UMSocialSnsTypeSina:
            snsType = UMShareToSina
        case UMSocialSnsTypeWechatSession:
            snsType = UMShareToWechatSession
        case UMSocialSnsTypeWechatTimeline:
            snsType = UMShareToWechatTimeline
        case UMSocialSnsTypeMobileQQ:
            snsType = UMShareToTencent
        default:
            snsType = UMShareToSina
        }
        UMSocialDataService.defaultDataService().postSNSWithTypes([snsType], content: model.content, image: model.image, location: model.location, urlResource: model.urlSource, presentedController: presentedController) { (response) -> Void in
            if (response.responseCode == UMSResponseCodeSuccess) {
                success?(data:response.data)
            } else {
                fail?(error: NSError(domain: response.message, code: Int(response.responseCode.rawValue), userInfo: response.data))
            }
        }
    }
}

extension AppDelegate {
    
    func UMSocialConfig() {
        UMSocialData.setAppKey("55f93b13e0f55a3ced002115")
        
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret: "db426a9829e4b49a0dcac7b4162da6b6", url: "http://www.umeng.com/social")
        UMSocialQQHandler.setQQWithAppId("100424468", appKey: "c7394704798a158208a74ab60104f0ba", url: "http://www.umeng.com/social")
        UMSocialSinaHandler.openSSOWithRedirectURL("http://sns.whalecloud.com/sina2/callback")
    }
    
    /*
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
    return UMSocialSnsService.handleOpenURL(url)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return UMSocialSnsService.handleOpenURL(url)
    }*/
}



