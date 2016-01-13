//
//  NetManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import Foundation

class NetManager: NSObject {
    static let instance = NetManager()
    
    var contenstType:String
    var manager:NSURLSession?
    
    private override init() {
        self.contenstType = "text/html"  // "application/json"
        
        super.init()
        
        self.manager = NSURLSession.sharedSession()
    }
    
    func function(){
        print(index)
    }
    
    internal final func addRequest(method:String, url:String, parameter:AnyObject?, callback:(data: NSData?, response: NSURLResponse?, error: NSError?)->Void) {
        
        if method == "GET" {
            //append parameter to the last of url newURL += "?" + Network().buildParams(parameter)
        }
        
        guard let URL = NSURL(string: url) else {
            let error = NSError(domain: "error url", code: -1, userInfo: ["method" : method, "url" : url])
            callback(data: nil, response: nil, error: error)
            return
        }
        
        let request = NSMutableURLRequest(URL: URL, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 10)
        request.HTTPMethod = method
        
        if method == "POST" {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            //request.HTTPBody =   encoded parameter  //Network().buildParams(parameter).dataUsingEncoding(NSUTF8StringEncoding)
        }
        let task = manager?.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            callback(data: data, response: response, error: error)
            
            //callback(data: data, response: response, error: error)
        })
        task?.resume()
        
    }
    
    
    
}




#if false
    import AFNetworking
#endif
extension NetManager {
    /*
    #if false
    var manager:AFHTTPSessionManager?
    
    func afnetworkConfig(type:ContentTypes?) -> Void {
    if let type = type {
    manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: type.rawValue)
    }
    }
    
    //AFNetworking 已经做好了任务调度 管理，不需要这里管理请求队列
    
    manager = AFHTTPSessionManager()
    manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "text/html")
    
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
    
    //MARK: 字典传入转JSON
    #endif
*/
}


