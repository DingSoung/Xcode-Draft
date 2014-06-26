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
        genNumber()
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
    
    func genNumber(){
        //10以内的随机数，为“1”时 结果时4，有十分之一概率为4
        let randv = Int(arc4random_uniform(10))
        println(randv)
        var seed:Int = 2
        if(randv == 1){
            seed = 4
        }
        //随机生成数字出现的位置
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        //显示数字
        insertTile((row,col), value:seed)
    }
    
    func insertTile(pos:(Int, Int), value:Int){
        let (row, col) = pos
        
        let x = 30 + CGFloat(col) * (width + padding)
        let y = 80 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos:CGPointMake(x,y), width:width, value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        
        //数字出现的动态效果 0.3秒内由小变大
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        UIView.animateWithDuration(0.3, delay:0.1, options:
            UIViewAnimationOptions.TransitionNone, animations:{
                ()->Void in
                tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            },
            completion:{
                (finished:Bool) ->Void in
                UIView.animateWithDuration(0.08, animations:{
                    ()-> Void in
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                    })
        })
    }
}
