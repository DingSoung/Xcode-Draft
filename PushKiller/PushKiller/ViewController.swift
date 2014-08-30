//
//  ViewController.swift
//  PushKiller
//
//  Created by 丁松 on 14-8-16.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        println("Hi ViewController")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBOutlet var Start: [UIButton]!
//    @IBAction func Start(sender: AnyObject) {
//        enterSence(true)
//    }
    
//    func enterSence(SenseChiose:Bool){
//        if(SenseChiose) {
//            println("Enter setting Dilog")
//            self.presentViewController(settingViewController(), animated: true, completion: {println("Setting Done")})
//        } else {
//            let Sense = messageViewController()
////            present View 只能是在当前类型下的class 现实相同的view，比如setting 和这个viewcontroller是相同的，可以present，而message就不行
////            self.presentViewController(Sense, animated: true, completion: nil)
//        }
//        //    let message = settingViewController()
//        //    self.presentViewController(message, animated: true, completion: nil)
//    }
    
}


//        var root = ViewController()
//        var navCtrl=UINavigationController(rootViewController:root)
//        self.window!.rootViewController=navCtrl



/*

self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
self.window!.backgroundColor = UIColor.whiteColor()
self.window!.makeKeyAndVisible()
var root = tabViewController()
var navCtrl=UINavigationController(rootViewController:root)
self.window!.rootViewController=navCtrl
*/
/*

@IBAction func Start(sender: AnyObject) {
let alertView = UIAlertView()
alertView.title = "开始"
alertView.message = "游戏开始,准备好吗?"
alertView.addButtonWithTitle("Ready Go!")
alertView.show()
alertView.delegate = self
}
*/
/*
//前面执行完后自动跳到这里
func alertView(alertView:UIAlertView,clickedButtonAtIndex buttonIndex:Int){
self.presentViewController(tabViewController(), animated: true, completion: nil)
}
*/
/*
init(coder aDecoder: NSCoder!) {
}
init() {
var viewSetting = settingViewController()
viewSetting.title = "设置"
var viewMessage = messageViewController()
viewMessage.title = "消息回"
var Setting = UINavigationController(rootViewController:viewSetting)
var Message = UINavigationController(rootViewController:viewMessage)
self.viewControllers = [Setting, Message]
self.selectedIndex = 0
}
*/
