//
//  GCDManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//   http://swifter.tips/gcd-delay-call/

import Foundation

class GCDManager: NSObject {
	
	typealias Task = (cancel : Bool) -> ()
	
	class func delay(time:NSTimeInterval, block:()->()) -> Task? {
        // generate task
		let task: Task? = { (cancel:Bool) -> Void in
            if (cancel == false) {
                if let dispatchBlock = block as dispatch_block_t? {
					dispatch_async(dispatch_get_main_queue(), dispatchBlock);
				}
			}
		}
        //delayExcuse
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW,Int64(time * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            {()->Void in    //参数不可为optopnal 所以包一层
                task?(cancel: false)
            }
        )
		return task;
	}
	
    class func cancel(task:Task?) {
		task?(cancel: true)
	}
    class func resume(task:Task?) {
        task?(cancel: false)
    }
}

