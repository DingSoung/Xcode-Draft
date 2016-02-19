//
//  PieChartView.swift
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class PieChartModel: NSObject {
    var value:Double = 0.0
    var color        = UIColor.whiteColor()
    
    convenience init(value: Double, color: UIColor) {
        self.init()
        self.value = value
        self.color = color
    }
}

protocol PieChartViewDelegate {
    func demoFunc()
}
class PieChartView: UIView {
    var models:[PieChartModel] = []
    
    var lineWidth:CGFloat = 1.0
    var fillColor:UIColor = UIColor.brownColor()
    
    var delegate:PieChartViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.models = [
            PieChartModel(value: 121, color: UIColor.redColor()),
            PieChartModel(value: 222, color: UIColor.greenColor()),
            PieChartModel(value: 333, color: UIColor.blueColor()),
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
        
         self.delegate?.demoFunc()
        
        let radius = min(self.bounds.size.width, self.bounds.size.height) * 0.5
        let origin = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        let clockwise = true
        
        var startPercent:Double = 0
        var capacityPercent:Double = 0
        var total:Double = 0
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, self.lineWidth)
        
        for model in self.models {
            total = total + model.value
        }
        if total <= 0 {
            return
        }
        for model in self.models {
            
            // Different Color.
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            self.fillColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            CGContextSetRGBStrokeColor(context, r, g, b, a)
            model.color.getRed(&r, green: &g, blue: &b, alpha: &a)
            CGContextSetRGBFillColor(context, r, g, b, a)
            
            // Different Size.
            capacityPercent = model.value / total;
            
            // Draw arc.
            CGContextMoveToPoint(context, origin.x, origin.y);
            CGContextAddArc(context, origin.x, origin.y, radius, CGFloat(startPercent * 2 * M_PI), CGFloat((startPercent + capacityPercent) * 2 * M_PI), clockwise ? 0 : 1); //绘制
            CGContextClosePath(context); //关闭起点和终点
            CGContextDrawPath(context, CGPathDrawingMode.FillStroke); //渲染
            
            // net step
            startPercent = startPercent + capacityPercent;
        }
    }
}
