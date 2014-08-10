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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    将控添加到storyboard，拉操作，拖到这里，就会有UIPickerView, 进去后会看到一些函数是用来配置的
    @IBOutlet weak var timePicker: UIPickerView!
    let timeZone = ["码农，半夜别吵我",
        "上班族，早九晚五",
        "小学生作息",
        "中学生，早晚要自习",
        "大学生，随意睡懒觉"]
    //    列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    //    行数
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        //        不能用sizeof()
        return timeZone.count
    }
    //    每一行显示的类容
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        return timeZone[row];
    }
//    控制宽度高度
    func pickerView(pickerView: UIPickerView!, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    func pickerView(pickerView: UIPickerView!, rowHeightForComponent component: Int) -> CGFloat {
        return 21
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
//        选择后执行
        var i = 0
    }
    
    
    @IBOutlet weak var messageLable: UILabel!
    @IBOutlet weak var filterPersent: UILabel!
    @IBOutlet weak var messageSlider: UISlider!
    let messageFilter = ["不屏蔽",
        "屏蔽明显的广告",
        "屏蔽推广信息，推荐",
        "蔽应用更新",
        "屏蔽所有非IM的通知，订阅",
        "屏蔽IM类的非联系人信息，社交，空间等",
        "屏蔽IM类公众信息，如群",
        "屏蔽IM信息",
        "屏蔽邮箱等非紧急信息",
        "屏蔽所有推送消息，短信，语音信箱，除了电话"]
    @IBAction func messageFilter(sender: AnyObject) {
        messageLable.text = messageFilter[(Int)(messageSlider.value * (Float)(messageFilter.count - 1))]
    var str = NSString(format:"%2.1f",(messageSlider.value * 100))
        filterPersent.text = "\(str)%"
    }
    
    
    
    var msgstack:NSString = "later"
    func configmsgstack() {
        switch msgstack {
        case "remind":
            let msgstackdetail = "提醒我看"
        case "freetime":
            let msgstackdetail = "稍后看想看就看"
        case "ingor":
            let msgstackdetail = "忽略掉，不看"
        default:
            msgstack = "remind"
        }
    }
}

