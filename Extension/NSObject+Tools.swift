//
//  NSObjec+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/12.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import Foundation
extension NSObject {
    
    /**
     闭包实现 C中的代码块功能
     */
    public func closure(
        mark:String? = "",
        run:Bool? = true,
        block:()->Void,
        complete:(()->Void)? = {()->Void in
            print("执行完毕")
        }) {
            if run != true { return }
            block()
            complete?()
    }
    public func closure(block:()->Void) {
        self.closure(block: block, complete: nil)
    }
    
    /**
     交换两个值
     */
    public func swep<T>(inout a:T, inout b:T) {
        let temp = a
        a = b
        b = temp
    }
    
    
    /**
     Json String to model
     */
    convenience init(jsonStr: String) {
        self.init()
        let JSONData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        do {
            let JSONDictionary = try NSJSONSerialization.JSONObjectWithData(JSONData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            for (key, value) in JSONDictionary {
                let keyName = key as! String
                let keyValue: String = value as! String
                if (self.respondsToSelector(NSSelectorFromString(keyName))) {
                    self.setValue(keyValue, forKey: keyName)
                }
            }
        } catch {
            print(error)
        }
    }
    
    /**
     Json Dict to model
     */
    convenience init(jsonDict : [String : AnyObject]) {
        self.init()
        self.setValuesForKeysWithDictionary(jsonDict)
    }
    
    //MARK: 字典转model array
    /*
    class func modelWithArray(dictArray:[NSDictionary]) -> NSArray {
    var dsts: NSMutableArray = []
    for src in dictArray {
    var dst = self.new()
    dst.setValuesForKeysWithDictionary(src as [NSObject : AnyObject])
    dsts.addObject(dst)
    }
    return dsts
    }*/
    /*
    func setValue(value: AnyObject!, forUndefinedKey key: String) {
        #if DEBUG
            print("undefined \(key):\(value)")
        #endif
        //override this func to deal with the key and value
    }*/

    
    
}
