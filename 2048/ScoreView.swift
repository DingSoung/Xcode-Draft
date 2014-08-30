//
//  ScoreView.swift
//  2048
//
//  Created by 丁松 on 14-7-5.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

protocol ScoreViewProtocol{
    func changeScore(value s:Int)
}

class ScoreView:UIView, ScoreViewProtocol
{
    var label:UILabel
    
    let defaultFrame = CGRectMake(0,0,100,30)
    
    var score:Int = 0{
    didSet{
        label.text = "分数:\(score)"
    }
    }
    
    init()
    {
        label = UILabel(frame:defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame:defaultFrame)
        
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name:"微软雅黑", size:16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    func changeScore(value s:Int)
    {
        score = s
    }
}

class BestScoreView:ScoreView, ScoreViewProtocol
{
    var bestscore:Int  = 0{
    didSet{
        label.text = "最高分:\(bestscore)"
    }
    }
    
    override func changeScore(value s:Int)
    {
        bestscore = s
    }
}

