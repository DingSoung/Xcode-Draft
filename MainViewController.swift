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
    //Game Mode
    var gmodel:GameModel
    //Store number of labelstr_t
    var tiles:Dictionary<NSIndexPath,TileView> //can not add "!"
    //var tilesVals:
    
    init(){
        self.backgrounds = Array<UIView>()
        self.tiles = Dictionary()
        self.gmodel = GameModel(dimension: self.dimension)
        super.init(nibName:nil, bundle:nil)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //绘制背景和方格
        setupBackground()
        setupButtons()
        for i in 0..16 {
            genNumber()
        }

    }
    
    func setupButtons(){
        var cv = ControlView()
        var btnreset = cv.createButton("Reset", action:Selector("resetTapped"), sender:self)
        btnreset.frame.origin.x = 50
        btnreset.frame.origin.y = 400
        self.view.addSubview(btnreset)
        
        var btngen   = cv.createButton("New NO.", action:Selector("genTapped"), sender:self)
        btngen.frame.origin.x = 170
        btngen.frame.origin.y = 400
        self.view.addSubview(btngen)
    
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
    
    func resetTapped(){
        println("reset")
        for(key, tile) in tiles {
            tile.removeFromSuperview()
        }
        gmodel.initTiles()
    }
    func genTapped(){
        println("gen number")
        genNumber()
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
        
        
        if(gmodel.isFull()) {
            println("position is full")
            return
        }
        if(gmodel.setPosition(row, col: col, value: seed) == false) {
            genNumber()
            return
        }
        
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
        
        var index = NSIndexPath(forRow:row, inSection:col)
        tiles[index] = tile
        
        
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
