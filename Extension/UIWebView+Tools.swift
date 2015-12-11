//
//  UIWebView+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/27.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import JavaScriptCore
import UIKit
extension UIWebView: UIWebViewDelegate {
    
    func addJsTarget(function:String, block : @convention(block) (AnyObject) -> Void) {
        if let context = self.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext {
            context.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: function)
            
            
        }
    }
    
    func runJsFunction(function:String, parameter:[AnyObject]) -> AnyObject? {
        if let context = self.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext {
            let factorial = context.objectForKeyedSubscript(function)
            return factorial.callWithArguments(parameter)
        } else {
            return nil
        }
    }
}



