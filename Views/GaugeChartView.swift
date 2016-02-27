//
//  GaugeChartView.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 2/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

// ref http://www.jianshu.com/p/ed928a6e8adf

import UIKit

class GaugeChartView: UIView {
    
    var maxAngular:CGFloat = 90.0;
    var circleWidth:CGFloat = 50;
    
    var process:CGFloat = 0.40;
    var processBackColor = UIColor.grayColor()
    var processColors = [UIColor.greenColor(), UIColor.yellowColor(), UIColor.orangeColor()]
    
    var pointerRadius:CGFloat = 60;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // Old code
        // R - sign(90 - maxAngular * 0.5) * R < totalHeight - circleWidth
        // R * cos(90 - maxAngular * 0.5) * 2 < totalWidth - circleWidth
        //let minR1 = (self.frame.size.height - self.circleWidth) / (1 - cos(CGFloat(maxAngular) * 0.5))
        //let minR2 = (self.frame.size.width - self.circleWidth) / (2 * (1 - sin(CGFloat(maxAngular) * 0.5)))
        

        
        let origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5)
        let radius = min(rect.size.width, rect.size.height) * 0.5 - self.circleWidth * 0.5;
        let endAngle = 90.0 - self.maxAngular * 0.5;
        let startAngle = 180.0 - endAngle;
        let clockwise = true
        
        // process background
        let processBack = UIBezierPath() //UIBezierPath(ovalInRect: rect) //   [UIBezierPath bezierPath];
        processBack.lineCapStyle = CGLineCap.Round
        processBack.addArcWithCenter(origin, radius: radius, startAngle: startAngle / 180.0 * CGFloat(M_PI), endAngle: endAngle / 180.0 * CGFloat(M_PI), clockwise: clockwise)
        self.processBackColor.setStroke()
        processBack.lineWidth = self.circleWidth;
        processBack.stroke()
        
        // pointer background
        let pointerBackground = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - self.pointerRadius, rect.size.height * 0.5 - self.pointerRadius, self.pointerRadius * 2, self.pointerRadius * 2))
        self.processBackColor.setFill()
        pointerBackground.fill()
        
        
        // process
        let process = UIBezierPath()
        process.lineCapStyle = CGLineCap.Round
        process.addArcWithCenter(origin, radius: radius, startAngle: startAngle / 180.0 * CGFloat(M_PI), endAngle: (startAngle + self.maxAngular) / 180.0 * CGFloat(M_PI), clockwise: clockwise)
        self.processColors[0].setStroke()
        process.lineWidth = self.circleWidth * 0.75;
        process.stroke()
        
        // pointeRound
        let pointeRound = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - self.pointerRadius * 0.75, rect.size.height * 0.5 - self.pointerRadius * 0.75, self.pointerRadius * 2 * 0.75, self.pointerRadius * 2 * 0.75))
        self.processColors[0].setFill()
        pointeRound.fill()
        // pointerTriangle
        let pointerTriangle = UIBezierPath()
        let pointerTriangleAngular = startAngle - self.maxAngular * self.process
        pointerTriangle.moveToPoint(CGPointMake(
            origin.x + self.pointerRadius * sin(pointerTriangleAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * cos(pointerTriangleAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + self.pointerRadius * 0.75 * sin((pointerTriangleAngular + 90) / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * 0.75 * cos((pointerTriangleAngular + 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + self.pointerRadius * 0.75 * sin((pointerTriangleAngular - 90) / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * 0.75 * cos((pointerTriangleAngular - 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + self.pointerRadius * sin(pointerTriangleAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * cos(pointerTriangleAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.closePath()
        self.processColors[0].setFill()
        pointerTriangle.fill()
        pointerTriangle.stroke()
        
        
        
    }

}






