//
//  NSString+Tools.swift
//  DEMO
//
//  Created by D.Alex on 12/15/15.
//  Copyright © 2015 Alex. All rights reserved.
//

import Foundation
extension NSString {
    
    /**
     string to dictionary
     */
    var jsonDict: NSDictionary? {
        let JSONData = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        do {
            if let JSONDictionary = try NSJSONSerialization.JSONObjectWithData(JSONData!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                return JSONDictionary
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    var urlToDict: NSDictionary {
        let dict:NSDictionary = ["" : ""]
        let params = self.componentsSeparatedByString("&")
        for param in params {
            let strs = param.componentsSeparatedByString("=")
            if strs.count >= 2 {
                if let value = strs[1].stringByRemovingPercentEncoding {
                    dict.setValue(value, forKey: strs[0])
                } else {
                    print("un-resolve key:\(strs[0]) value:\(strs[1])")
                }
            } else {
                print("un-resolve strs \(strs)")
            }
        }
        return dict
    }

}
