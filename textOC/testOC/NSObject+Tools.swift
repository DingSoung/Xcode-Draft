//
//  NSObjec+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/12.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

extension NSObject {
    
    /**
     闭包实现 C中的代码块功能
     */
    func closure(
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
    func closure(block:()->Void) {
        self.closure(block: block, complete: nil)
    }
    
    /**
     交换两个值
     */
    func swep<T>(inout a:T, inout b:T) {
        let temp = a
        a = b
        b = temp
    }
    
    //MARK: JSON转model
    #if false
    init(JSONString: String) {
    super.init()
    var error : NSError?
    let JSONData = JSONString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
    let JSONDictionary = NSJSONSerialization.JSONObjectWithData(JSONData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
    
    for (key, value) in JSONDictionary {
    let keyName = key as! String
    let keyValue: String = value as! String
    if (self.respondsToSelector(NSSelectorFromString(keyName))) {
				self.setValue(keyValue, forKey: keyName)
    }
    }
    }
    #endif
    init(JSONDic : [String : AnyObject]) {
        super.init()
        self.setValuesForKeysWithDictionary(JSONDic)
    }
    class func modelWithArray(dictArray:[NSDictionary]) -> NSArray {
        let array: NSMutableArray = []
        for dic in dictArray {
            let model = super.init()
            model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
            array.addObject(model)
        }
        return array
    }
    override func setValue(value: AnyObject!, forUndefinedKey key: String) {
        super.setValue(value, key)
        print("未定义的key:\(key) for value:\(value)", terminator: "")
    }
    
}
