//
//  settingViewController.swift
//  PushKiller
//
//  Created by 丁松 on 14-8-12.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit
class settingViewController: UIViewController {
    
    let timeDetailTable = ["码农，半夜别吵我",
        "上班族，早九晚五",
        "小学生作息",
        "中学生，早晚要自习",
        "大学生，随意睡懒觉"]
    let filterDetailTable = ["不屏蔽",
        "屏蔽明显的广告",
        "屏蔽推广信息，推荐",
        "蔽应用更新",
        "屏蔽所有非IM的通知，订阅",
        "屏蔽IM类的非联系人信息，社交，空间等",
        "屏蔽IM类公众信息，如群",
        "屏蔽IM信息",
        "屏蔽邮箱等非紧急信息",
        "屏蔽所有推送消息，短信，语音信箱，除了电话"]
    
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var filterSlider: UISlider!
    @IBOutlet weak var filterDetail: UILabel!
    @IBOutlet weak var filterPersent: UILabel!
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder);
    }
    override init() {
        super.init();
        println("Hi setting Dilog")
        
        filterSlider.value = 0.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        在这里配置场景
        
        
        filterDetail.text = filterDetailTable[(Int)(filterSlider.value * (Float)(filterDetailTable.count - 1))]
        var str = NSString(format:"%2.1f",(filterSlider.value * 100))
        filterPersent.text = "\(str)%"
    }
    
    //    列数
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    //    行数
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        //        不能用sizeof()
        return timeDetailTable.count
    }
    //    每一行显示的类容
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
        return timeDetailTable[row];
    }
    //    控制宽度高度
    func pickerView(pickerView: UIPickerView!, widthForComponent component: Int) -> CGFloat {
        return 260
    }
    func pickerView(pickerView: UIPickerView!, rowHeightForComponent component: Int) -> CGFloat {
        return 21
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        //  选择后执行
        var i = 0
    }
    
    @IBAction func filterConfig(sender: AnyObject) {
        filterDetail.text = filterDetailTable[(Int)(filterSlider.value * (Float)(filterDetailTable.count - 1))]
        var str = NSString(format:"%2.1f",(filterSlider.value * 100))
        filterPersent.text = "\(str)%"
    }
    
    
    
    
    
    
    
}