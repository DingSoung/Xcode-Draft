//
//  NetworkManager.swift
//  DEMO
//
//  Created by D.Alex on 12/21/15.
//  Copyright © 2015 Alex. All rights reserved.
//

import Foundation

class NetworkRequest: NSMutableURLRequest {
    var startTime:NSTimeInterval
    var retryTimes:Int
    
    override init(URL: NSURL, cachePolicy: NSURLRequestCachePolicy, timeoutInterval: NSTimeInterval) {
        self.startTime = NSTimeIntervalSince1970
        self.retryTimes = 0
        super.init(URL: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    }
    
    convenience init(URL: NSURL, cachePolicy: NSURLRequestCachePolicy, timeoutInterval: NSTimeInterval, startTime:NSTimeInterval) {
        self.init(URL: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        self.startTime = startTime
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NetworkManager: NSObject {
    
    static let instance = NetworkManager()
    var session:NSURLSession
    
    private override init() {
        session = NSURLSession.sharedSession()
        
        super.init()
        
    }
    deinit {
    }
    
    func generateRequest(httpMethod:String, url:String, parameter:NSData?) -> NetworkRequest? {
        
        guard let URL = NSURL(string: url) else {
            return nil
        }
        let request = NetworkRequest(URL: URL, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 12, startTime: NSTimeIntervalSince1970)
        request.HTTPMethod = httpMethod
        if httpMethod == "POST" {
            request.HTTPBody = parameter
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    func processTask(request:NetworkRequest, success:((data:NSData)->Void), fail:((error:NSError)->Void)) -> NSURLSessionDataTask {
        
        //check network available
        
        let task = self.session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                success (data: data)
            } else {
                if request.retryTimes++ >= 5 || NSTimeIntervalSince1970 >= request.startTime + 60 {
                    if let error = error {
                        fail(error: error)
                    } else {
                        fail(error: NSError(domain: "requet timeout", code: -1, userInfo: nil))
                    }
                } else {
                    self.processTask(request, success: success, fail: fail)
                }
            }
        }
        task.resume()
        return task
    }
}

extension NetworkManager {
    
    //https://lvwenhan.com/ios/455.html
    
    class func POST(url:String, parameter:NSDictionary, success:((data: NSData) -> Void), fail:((error: NSError) -> Void)) -> Void {
        let parameter = NSKeyedArchiver.archivedDataWithRootObject(parameter)
        guard let request = NetworkManager.instance.generateRequest("POST", url: url, parameter: parameter) else {
            fail(error: NSError(domain: "generate request", code: -1, userInfo: ["url" : url, "parameter": parameter]))
            return
        }
        NetworkManager.instance.processTask(request, success: success, fail: fail)
    }
    
    class func GET(url:String, parameter:NSDictionary, success:((data: NSData) -> Void), fail:((error: NSError) -> Void)) {
        guard let request = NetworkManager.instance.generateRequest("GET", url: url, parameter: nil) else {
            fail(error: NSError(domain: "generate request", code: -1, userInfo: ["url" : url]))
            return
        }
        NetworkManager.instance.processTask(request, success: success, fail: fail)
    }
}



