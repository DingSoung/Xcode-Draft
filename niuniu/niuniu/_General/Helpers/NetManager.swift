//
//  NetManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit
import AFNetworking

enum ContentTypes: String {
    case textHTML = "text/html"
    case applicationJSON = "application/json"
}


class NetManager {
    //AFNetworking 已经做好了任务调度 管理，不需要这里管理请求队列
    
    static let instance = NetManager()
    private init() {
        manager = AFHTTPSessionManager()
        manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "text/html")
    }
    
    var manager:AFHTTPSessionManager?
    
    func afnetworkConfig(type:ContentTypes?) -> Void {
        if let type = type {
            manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: type.rawValue)
        }
    }
    
    func autoRequest(url:String, parameter:AnyObject?, type:ContentTypes?, success:(NSURLSessionDataTask, AnyObject) -> Void, fail:(NSURLSessionDataTask, NSError) -> Void){
        self.afnetworkConfig(type)
        
        if AFNetworkReachabilityManager.sharedManager().reachable != true {
            fail(NSURLSessionDataTask(), NSError(domain: "network not reachable", code: -1, userInfo: nil))
            return
        }
        
        if let parameter: AnyObject = parameter {
            manager?.POST(url, parameters: parameter, success: { (task, obj) -> Void in
                success(task, obj)
            }, failure: { (task, error) -> Void in
                fail(task, error)
            })
        }else{
            manager?.GET(url, parameters: nil, success: { (task, obj) -> Void in
                success(task, obj)
                }, failure: { (task, error) -> Void in
                    fail(task, error)
            })
            
        }
    }
}

extension NetManager {
    
    //MARK: 字典传入转JSON
}



