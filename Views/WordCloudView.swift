//
//  WordCloudView.swift
//  DEMO-IB
//
//  Created by Alex D. on 1/15/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class WordCloudModel: NSObject {
    var text:String = ""
    var value:Double = 0.0
    var color = UIColor.whiteColor()
    
    convenience init(text:String, value: Double, color: UIColor) {
        self.init()
        self.text = text
        self.value = value
        self.color = color
    }
}

class WordCloudView: UIView {
    
    var models:[WordCloudModel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.models = [
            WordCloudModel(text:"111", value: 121, color: UIColor.redColor()),
            WordCloudModel(text:"222", value: 222, color: UIColor.greenColor()),
            WordCloudModel(text:"333", value: 333, color: UIColor.blueColor()),
            WordCloudModel(text:"444", value: 333, color: UIColor.yellowColor()),
            WordCloudModel(text:"555", value: 333, color: UIColor.purpleColor()),
            WordCloudModel(text:"666", value: 333, color: UIColor.brownColor()),
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        for _ in models {
            //prepare word....
            let unitLenght:CGFloat = 20 //<-- min lenght of word
            var drawed = false
            
            //radius < view size * 0.5
            for (var latitude = 0; drawed == false && CGFloat(latitude) * unitLenght < 0.5 * min(self.frame.size.width, self.frame.size.height); latitude++) {
                
                //2 * M_PI * radius = perimeter
                //radian = unitLenght/radius = unitLenght / (latitude * unitLenght) = 1/latitude
                for (var radian = 0.0; drawed == false && radian < 2 * M_PI; radian = radian + 1.0 / Double(latitude)) {
                    
                    // preset 45
                    for (var angle = 0.0; drawed == false && angle < M_PI; angle = angle + 0.25 * M_PI) {
                        if (self.checkSpace() == true) {
                            drawed = true
                            self.asyncDrawWord()
                        }
                    }
                }
            }
        }
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetTextMatrix(context, CGAffineTransformIdentity)
        
        // 移动坐标原点 默认坐标原点在屏幕左下角
        CGContextTranslateCTM(context, 0 * self.frame.size.width, 1 * self.bounds.size.height)
        
        // 缩放比例  默认绘制方向的y轴正方向是向上的 改为向下
        CGContextScaleCTM(context, 1, -1)
        
        // 旋转 相对于原点(0, 0) CGContextRotateCTM(context, 5 * M_PI / 180);
        
        // 绘制通道 用于画text的区域
        let path = CGPathCreateMutable();
        CGPathAddRect(path, nil, self.bounds); //足够大的区域
        
        for var index = 0; index < self.models.count; index++ {
            // Config text font color
            let text = NSMutableAttributedString(string: self.models[index].text)
            text.addAttribute(kCTForegroundColorAttributeName as String, value: self.models[index].color, range: NSMakeRange(0, text.length))
            text.addAttribute(kCTFontAttributeName as String, value: CTFontCreateWithName("Courier", 28 + CGFloat(index) * 5, nil), range: NSMakeRange(0, text.length))
            
            //CGContextSetTextMatrix(context, CGAffineTransformMakeRotation(180 * CGFloat(M_PI) / 180.0)) //CGAffineTransformIdentity
            
            // Backup.
            CGContextSaveGState(context)
            
            // 配置坐标
            //let suggestedSize = text.boundingRectWithSize(CGSizeMake(rect.size.width, 99999999), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context: nil).size
            //CGContextTranslateCTM(context, (self.frame.size.width - suggestedSize.width) * 0.5, (self.frame.size.height - suggestedSize.height) * 0.5)
            //CGContextTranslateCTM(context, (self.frame.size.width) * 0.5, (self.frame.size.height) * 0.5)
            
            // 配置旋转角度
            CGContextRotateCTM(context, -15 * CGFloat(index) * CGFloat(M_PI) / 180.0);
            
            
            //根据AttributedString生成CTFramesetterRef
            let frameSetter = CTFramesetterCreateWithAttributedString(text)
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, text.length), path, nil)
            
            // Renter
            CTFrameDraw(frame, context!)
            
            // Restore.
            CGContextRestoreGState(context);
        }
    }
    
    private func checkSpace() -> Bool {
        return true
    }
    
    private func asyncDrawWord() {
        
    }
    
    
}


enum SomeType {
    case type1
    case type2
    case type3
}





