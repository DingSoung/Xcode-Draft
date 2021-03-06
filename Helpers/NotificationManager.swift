//
//  NotificationManager.swift
//  
//
//  Created by Ding Soung on 15/6/23.
//
//

import UIKit

class NotificationManager: NSObject {
	
	class var instance: NotificationManager {
		dispatch_once(&Inner.token){
			Inner.instance = NotificationManager() //只初始化一次
		}
		return Inner.instance!
	}
	private struct Inner {
		static var instance:NotificationManager? = nil
		static var token: dispatch_once_t = 0
	}
    private override init() {
        super.init()
    }
    
	//MARK: 定时发送通知消息
	internal func scheduleNotification(itemID:Int = 0,delaySeconds:NSTimeInterval? = 2,timeZone:NSTimeZone? = NSTimeZone.defaultTimeZone(),message:String? = "default meaasge form Notification Manager"){
		self.cancelNotification(itemID) //如果已存在该通知消息，则先取消
		let localNotification = UILocalNotification() //创建UILocalNotification来进行本地消息通知
		localNotification.fireDate =  NSDate(timeIntervalSinceNow: delaySeconds!) //推送时间（设置为x秒）
		localNotification.timeZone = timeZone //时区
		localNotification.alertBody = message //推送内容
		localNotification.soundName = UILocalNotificationDefaultSoundName //声音
		localNotification.userInfo = ["ItemID":itemID] //额外信息
		UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
	}
	func scheduleNotificationOC(itemID:Int,delaySeconds:NSTimeInterval,timeZone:NSTimeZone,message:String){
		self.scheduleNotification(itemID, delaySeconds: delaySeconds, timeZone: timeZone, message: message)
	}
	
	//MARK: 取消通知消息
	internal func cancelNotification(itemID:Int){
		//通过itemID获取已有的消息推送，然后删除掉，以便重新判断
		if let existingNotification = self.notificationForItem(itemID) as UILocalNotification? {
			UIApplication.sharedApplication().cancelLocalNotification(existingNotification)
		}
	}
	//MARK: 通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
	internal func notificationForItem(itemID:Int) -> UILocalNotification? {
        if let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications {
            for notification in allNotifications {
                var info = notification.userInfo as? Dictionary<String,Int>
                let number = info?["ItemID"]
                if number != nil && number == itemID {
                    return notification
                }
            }
        }
		return nil
	}
	
}
