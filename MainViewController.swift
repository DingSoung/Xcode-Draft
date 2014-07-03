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
    
    var tileVals: Dictionary<NSIndexPath, Int>
    
    init(){
        self.backgrounds = Array<UIView>()
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        self.gmodel = GameModel(dimension: self.dimension)
        super.init(nibName:nil, bundle:nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //绘制背景和方格
        setupBackground()
        setupSwipeGuestures()
        setupButtons()
        for i in 0..2 {
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
    
    func setupSwipeGuestures(){
        let upSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeUp")) //响应函数名为swipeUp
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target:self, action:Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func printTiles(tiles:Array<Int>){
        var count = tiles.count
        for var i = 0; i < count; i++ {
            if (i+1) % Int(dimension) == 0 {
                println(tiles[i])
            }else{
                print("\(tiles[i])\t")
            }
        }
        println("")
    }
    func swipeUp(){
        println("Swipe Up")
        gmodel.reflowUp()
        gmodel.mergeUp()
        gmodel.reflowUp()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        //resetUI()
        initUI()
        
        genNumber()
        /*
        for i in 0..dimension {
        for j in 0..dimension {
        var index = i * self.dimension + j
        insertTile((i, j), value:gmodel.mtiles[index])
        }
        }
        gmodel.copyFromMtiles()
        */
        
        
        /*for i in 0..dimension {
        for j in 0..dimension {
        var row:Int = i
        var col:Int = j
        var key = NSIndexPath(forRow:row, inSection:col)
        if(tileVals.indexForKey(key) != nil) {
        // if > 3, move up 1 row
        if (row > 1) {
        var value = tileVals[key]
        removeKeyTile(key)
        var index = row * dimension + col - dimension
        row = Int(index/dimension)
        col = index - row * dimension
        insertTile((row, col), value:value!)
        }
        
        }
        }
        }*/
    }
    func swipeDown(){
        println("Swipe Down")
        gmodel.reflowDown()
        gmodel.mergeDown()
        gmodel.reflowDown()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        //resetUI()
        initUI()
        genNumber()
    }
    func swipeLeft(){
        println("Swipe Left")
        gmodel.reflowLeft()
        gmodel.mergeLeft()
        gmodel.reflowLeft()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        //resetUI()
        initUI()
        genNumber()
    }
    func swipeRight(){
        println("Swipe Right")
        gmodel.reflowRight()
        gmodel.mergeRight()
        gmodel.reflowRight()
        printTiles(gmodel.tiles)
        printTiles(gmodel.mtiles)
        //resetUI()
        initUI()
        genNumber()
    }
    func removeKeyTile(key:NSIndexPath){
        var tile = tiles[key]!  //must init for tile.removeFormDuperview()
        var tileVal = tiles[key]
        
        tile.removeFromSuperview()
        tiles.removeValueForKey(key)
        tileVals.removeValueForKey(key)
    }
    
    func resetTapped(){
        println("reset")
        resetUI()
        gmodel.initTiles()
    }
    func initUI(){
        var index:Int
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        for i in 0..dimension{
            for j in 0..dimension{
                var index = i * self.dimension + j
                key = NSIndexPath(forRow:i, inSection:j)

                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) == nil)) {
                }
                if((gmodel.tiles[index] == 0) && (tileVals.indexForKey(key) != nil)) {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                    //insertTile((i, j), value: gmodel.tiles[index])
                }
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) == nil)) {
                    insertTile((i, j), value:gmodel.tiles[index])
                }
                if((gmodel.tiles[index] > 0) && (tileVals.indexForKey(key) != nil)) {
                    tileVal = tileVals[key]!
                    if (tileVal == gmodel.tiles[index]) {
                        tile = tiles[key]!
                        tile.removeFromSuperview()
                        
                        tiles.removeValueForKey(key)
                        tileVals.removeValueForKey(key)
                        
                        insertTile((i, j), value: gmodel.tiles[index])
                    }
                }
                //tile = tiles[key]!
                //tile.removeFromSuperview()
                /*if(gmodel.tiles[index] != 0){
                    insertTile((i, j), value:gmodel.tiles[index])
                }*/
            }
        }
    }
    func resetUI(){
        for(key, tile) in tiles {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity:true)
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
        tileVals[index] = value
        
        
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
