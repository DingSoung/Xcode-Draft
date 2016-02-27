//
//  GaugeChartView.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 2/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class GaugeChartView: UIView {
    
    var maxAngular:CGFloat = 120.0;
    var circleWidth:CGFloat = 20;
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // R - sign(90 - maxAngular * 0.5) * R < totalHeight - circleWidth
        // R * cos(90 - maxAngular * 0.5) * 2 < totalWidth - circleWidth
        let minR1 = (self.frame.size.height - self.circleWidth) / (1 - cos(CGFloat(maxAngular) * 0.5))
        let minR2 = (self.frame.size.width - self.circleWidth) / (2 * (1 - sin(CGFloat(maxAngular) * 0.5)))
        var radius = min(minR1, minR2)
        
        var origin = CGPointMake(self.center.x, self.circleWidth * 0.5 + radius)
        
        let clockwise = true
        
        
        
        radius = min(rect.size.width, rect.size.height) * 0.5;
        origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: rect) //   [UIBezierPath bezierPath];
        
        ovalPath.addArcWithCenter(origin, radius: radius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: clockwise)
        
        UIColor.redColor().setStroke()
        
        ovalPath.lineWidth = 30;
        ovalPath.stroke()

    }

}






