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
    var msgtime:Int8 = 0
    var msgfilter:Int8 = 50
    var msgstack:NSString = "later"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quiet(sender: UISlider) {
        //     以小时为单位  0 ~ 2^8 小时
        msgfilter = (Int8)(sender.value * 100)
        msgfilter = (msgfilter/10) * 10
    }
    
    @IBOutlet weak var timePicker: UIPickerView!
    //    将控添加到storyboard，拉操作，拖到这里，就会有UIPickerView, 进去后会看到一些函数是用来配置的
    @IBOutlet weak var picker: UIPickerView!
    //    列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 2
    }
    //    行数
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    //    显示的类容
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        return "第\(row)行"
    }
    
    
    func configtime() {
        
    }
    
    func configfilter() {
        switch msgfilter {
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
            msgfilter = 50
        }
        
    }
    
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

