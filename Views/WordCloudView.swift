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
        
        for _ in self.models {
            //prepare word....
            let unitLenght:CGFloat = 20 //<-- min lenght of word
            var drawed = false
            
            //radius < view size * 0.5
            for (var latitude = 0; drawed == false && CGFloat(latitude) * unitLenght < 0.5 * min(rect.size.width, rect.size.height); latitude++) {
                
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
        
        // 缩放比例  默认绘制方向的y轴正方向是向上的 改为向下->向下
        CGContextScaleCTM(context, 1.0, -1.0)
        
        // 绘制通道 用于画text的区域
        let path = CGPathCreateMutable();
        CGPathAddRect(path, nil, rect); //足够大的区域
        
        for var index = 0; index < self.models.count; index++ {
            // Config text font color
            let text = NSMutableAttributedString(string: self.models[index].text)
            text.addAttribute(kCTForegroundColorAttributeName as String, value: self.models[index].color, range: NSMakeRange(0, text.length))
            text.addAttribute(kCTFontAttributeName as String, value: CTFontCreateWithName("Courier", 28 + CGFloat(index) * 5, nil), range: NSMakeRange(0, text.length))
            
            // Backup.
            CGContextSaveGState(context)
            
            
            // 配置坐标
            CGContextTranslateCTM(context, 0 * rect.size.width, -1 * rect.size.height)
            
            // 配置旋转角度
            CGContextRotateCTM(context, -15 * CGFloat(index) * CGFloat(M_PI) / 180.0);
            
            
            
            //let suggestedSize = text.boundingRectWithSize(CGSizeMake(rect.size.width, 99999999), options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], context: nil).size
            //CGContextTranslateCTM(context, (self.frame.size.width - suggestedSize.width) * 0.5, (self.frame.size.height - suggestedSize.height) * 0.5)
            //CGContextTranslateCTM(context, (self.frame.size.width) * 0.5, (self.frame.size.height) * 0.5)
            
            //根据AttributedString生成CTFramesetterRef
            let frameSetter = CTFramesetterCreateWithAttributedString(text)
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, text.length), path, nil)
            
            // Renter
            CTFrameDraw(frame, context!)
            
            // Restore.
            CGContextRestoreGState(context);
        }
        
        
        
        /*
        // Start drawing
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        // Retrieve the center and set a radius
        
        // Start by adjusting the context origin
        // This affects all subsequent operations
        CGContextTranslateCTM(context, rect.size.width * 0.5, rect.size.height * 0.5);
        
        // Iterate through the alphabet
        for (var i = 0; i < self.models.count; i++) {
            // Retrieve the letter and measure its display size
            let letter = self.models[i].text as NSString
            let letterSize = letter.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14.0)])
            
            // Calculate the current angular offset
            let theta = CGFloat(i) * (2 * CGFloat(M_PI) / CGFloat(self.models.count));
            
            // Encapsulate each stage of the drawing
            CGContextSaveGState(context);
            
            
            // Rotate the context
            CGContextRotateCTM(context, theta);
            
            // Translate up to the edge of the radius and move left by
            // half the letter width. The height translation is negative
            // as this drawing sequence uses the UIKit coordinate system.
            // Transformations that move up go to lower y values.
            CGContextTranslateCTM(context, -letterSize.width / 2, -(min(rect.size.width * 0.5, rect.size.height * 0.5)));
            
            // Draw the letter and pop the transform state
            letter.drawAtPoint(CGPointMake(0, 0), withAttributes: [NSFontAttributeName: UIFont.systemFontOfSize(14.0)])
            
            
            CGContextRestoreGState(context);
        }
        
        // Retrieve and return the image
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //return image;*/
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





