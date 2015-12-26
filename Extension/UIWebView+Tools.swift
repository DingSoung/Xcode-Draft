//
//  UIWebView+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/27.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import JavaScriptCore
import UIKit
extension UIWebView {
    
    internal var context:JSContext? {
        get {
            return self.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext
        }
        set {
            if let newValue = newValue {
                self.context = newValue
            }
        }
    }
    
    public func addJsTarget(function:String, block: @convention(block)(AnyObject)->Void) {
        guard let context = self.context else {
            #if DEBUG
                print("web js load fail")
            #endif
            return
        }
        context.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: function)
    }
    
    public func runJsFunction(function:String, parameter:[AnyObject]) {
        guard let context = self.context else {
            #if DEBUG
                print("web js load fail")
            #endif
            return
        }
        let jsValue = context.objectForKeyedSubscript(function)
        jsValue.callWithArguments(parameter)
    }
    
    public func syncRunJsFunction(function:String, parameter:[AnyObject], complete:((value:JSValue)->Void)?) {
        let queue = dispatch_queue_create("JavaScriptCore.queue", nil);
        dispatch_sync(queue) { () -> Void in
            guard let context = self.context else {
                #if DEBUG
                    print("web js load fail")
                #endif
                return
            }
            let jsValue = context.objectForKeyedSubscript(function)
            let value = jsValue.callWithArguments(parameter)
            complete?(value: value)
        }
    }
}


