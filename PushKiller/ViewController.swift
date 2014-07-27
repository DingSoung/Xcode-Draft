//
//  ViewController.swift
//  PushKiller
//
//  Created by 丁松 on 14-7-27.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    var filter:Int8 = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quiet(sender: UISlider) {
        //以小时为单位  0 ~ 2^8 小时
        filter = (Int8)(sender.value * 100)
        filter = (filter/10) * 10
    }
    
    let vegetable = "red pepper"
    switch vegetable {
    case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
    case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
    case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
    default:
    let vegetableComment = "Everything tastes good in soup."
    }
    
    switch filter {
    case 0:
    let filterdetail = "10以内，不屏蔽"
    case 10:
    let filterdetail = "20以内,屏蔽明显的广告"
    case 20:
    let filterdetail = "30,屏蔽推广信息，推荐"
    case 30:
    let filterdetail = "40,蔽应用更新"
    case 40:
    let filterdetail = "屏蔽所有非IM的通知，订阅"
    case 50:
    let filterdetail = "屏蔽IM类的非联系人信息，社交，空间等"
    case 60:
    let filterdetail = "屏蔽IM类公众信息，如群"
    case 70:
    let filterdetail = "屏蔽IM信息"
    case 80:
    let filterdetail = "屏蔽邮箱等非紧急信息"
    case 90:
    let filterdetail = "屏蔽所有推送消息，短信，语音信箱，除了电话"
    default:
    filter - 50
    }
    
    
}

