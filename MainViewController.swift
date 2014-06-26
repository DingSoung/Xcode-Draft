//
//  MainTabViewController.swift
//  2048
//
//  Created by 丁松 on 14-6-15.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class MainViewController:UIViewController
{
    //维度
    var dimension:Int = 4
    //过关值
    var maxnumber:Int = 2048
    //宽度
    var width:CGFloat = 60
    // 间距
    var padding:CGFloat = 6
    
    //背景
    var backgrounds:Array<UIView>
    
    init(){
        self.backgrounds = Array<UIView>()
        super.init(nibName:nil, bundle:nil)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //绘制背景和方格
        setupBackground()
    }
    
    func setupBackground(){
        var x:CGFloat = 30
        var y:CGFloat
        
        for i in 0..dimension{
            y = 80
            for j in 0..dimension{
                var background = UIView(frame:CGRectMake(x,y,width,width))
                background.backgroundColor = UIColor.darkGrayColor()
                    self.view.addSubview(background)
                backgrounds += background
                y += padding + width
            }
            x += padding + width
        }
    }
    
}
