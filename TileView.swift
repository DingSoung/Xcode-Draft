//
//  TileView.swift
//  2048
//
//  Created by 丁松 on 14-6-26.
//  Copyright (c) 2014年 丁松. All rights reserved.
//

import UIKit

class TileView:UIView{
    let colorMap = [
        2:UIColor.redColor(),
        4:UIColor.orangeColor(),
        8:UIColor.yellowColor(),
        16:UIColor.greenColor(),
        32:UIColor.brownColor(),
        64:UIColor.blueColor(),
        128:UIColor.purpleColor(),
        256:UIColor.cyanColor(),
        512:UIColor.lightGrayColor(),
        1024:UIColor.magentaColor(),
        2048:UIColor.blackColor(),
    ]
    var value:Int = 0{
        didSet{
            backgroundColor = colorMap[value]
            numberLabel.text = "\(value)"
                    }
    }
    
    //label的央视配置
    var numberLabel: UILabel
    init(pos:CGPoint, width:CGFloat, value:Int){
        numberLabel = UILabel(frame:CGRectMake(0, 0, width, width))
        numberLabel.textColor = UIColor.whiteColor()
        numberLabel.textAlignment = NSTextAlignment.Center
        numberLabel.minimumScaleFactor = 0.5
        numberLabel.font = UIFont(name:"微软雅黑",size:20)
        numberLabel.text = "\(value)"
        super.init(frame:CGRectMake(pos.x, pos.y, width, width))
        addSubview(numberLabel)
        self.value = value
        backgroundColor = colorMap[value]
    
    }
}
