//
//  ViewController.swift
//  2048
//
//  Created by 丁松 on 14-6-24.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

//PlayGround 是一个测试“打草稿”的地方

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //按键的功能，弹出对话框，在storyboard中右键关联到这个函数
    @IBAction func StartGame(sender:UIButton){
        let alertView = UIAlertView()
        alertView.title = "开始"
        alertView.message = "游戏开始,准备好吗?"
        alertView.addButtonWithTitle("Ready Go!")
        alertView.show()
    }


}

