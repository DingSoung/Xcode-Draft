//
//  GaugeChartView.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 2/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

// ref http://www.jianshu.com/p/ed928a6e8adf

import UIKit

class GaugeChart: NSObject {
    var maxAngular:CGFloat = 240.0;
    var progress:CGFloat = 0.56;
    
    var progressSetValue:CGFloat = 0.2
    var progressSetColor = UIColor.grayColor()
    
    var progressBackColor = UIColor.lightGrayColor()
    var progressColors = [UIColor.greenColor(), UIColor.yellowColor(), UIColor.orangeColor()]
    
    var circleWidth:CGFloat = 50;
    var pointerRadius:CGFloat = 60;
    
    override init() {
        super.init()
        
        self.maxAngular = min(self.maxAngular, 360)
        self.progress = min(self.progress, 1)
        
        self.maxAngular = max(self.maxAngular, 0)
        self.progress = max(self.progress, 0)
        
        if self.progressColors.count < 0 {
            self.progressColors = [UIColor.greenColor()]
        }
        
        self.progressSetValue = min(progressSetValue, 1)
        self.progressSetValue = max(progressSetValue, 0)
    }
}

class GaugeChartView: UIView {
    
    var model = GaugeChart()
    
    internal var displayLink:CADisplayLink?
    internal var drawedPercent:CGFloat = 0
    
    func startAnimation() {
        self.drawedPercent = 0
        
        self.displayLink = CADisplayLink(target: self, selector: "tickAnimation")
        self.displayLink?.frameInterval = 1
        self.displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    func completeAnimation() {
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
    func tickAnimation() {
        self.setNeedsDisplay()
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.startAnimation()
    }
    
    deinit {
        self.completeAnimation()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5)
        let radius = min(rect.size.width, rect.size.height) * 0.5 - self.model.circleWidth * 0.5;
        
        let clockwise = true
        let startAngle:CGFloat = (clockwise ? -1 : 1) * ((180.0 - self.model.maxAngular) * 0.5 + self.model.maxAngular);
        
        // progress background
        let progressBack = UIBezierPath()
        progressBack.lineCapStyle = CGLineCap.Round
        progressBack.addArcWithCenter(origin, radius: radius,
            startAngle: startAngle / 180.0 * CGFloat(M_PI),
            endAngle: (startAngle + (clockwise ? 1 : -1) * self.model.maxAngular * 1.0000000) / 180.0 * CGFloat(M_PI),
            clockwise: clockwise)
        self.model.progressBackColor.setStroke()
        progressBack.lineWidth = self.model.circleWidth;
        progressBack.stroke()
        
        // pointer background
        let pointerBackground = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - self.model.pointerRadius, rect.size.height * 0.5 - self.model.pointerRadius, self.model.pointerRadius * 2, self.model.pointerRadius * 2))
        self.model.progressBackColor.setFill()
        pointerBackground.fill()
        
        let endAngular:CGFloat = startAngle + (clockwise ? 1 : -1) * self.model.maxAngular * self.drawedPercent
        
        // progress
        let progress = UIBezierPath()
        progress.lineCapStyle = CGLineCap.Round
        progress.addArcWithCenter(origin, radius: radius,
            startAngle: startAngle / 180.0 * CGFloat(M_PI),
            endAngle: endAngular / 180.0 * CGFloat(M_PI),
            clockwise: clockwise)
        self.model.progressColors[0].setStroke()
        progress.lineWidth = self.model.circleWidth * 0.75;
        progress.stroke()
        
        // progress End
        let progressEndRadius = self.model.circleWidth * 0.5 * 0.5
        let progressEnd = UIBezierPath(ovalInRect: CGRectMake(
            origin.x + radius * cos(endAngular / 180.0 * CGFloat(M_PI)) - progressEndRadius,
            origin.y + radius * sin(endAngular / 180.0 * CGFloat(M_PI)) - progressEndRadius,
            progressEndRadius * 2, progressEndRadius * 2))
        self.model.progressBackColor.setFill()
        progressEnd.fill()
        
        
        let pointerIndicaterRadius = self.model.pointerRadius * 0.8;
        // pointerPad
        let pointeRound = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - pointerIndicaterRadius, rect.size.height * 0.5 - pointerIndicaterRadius, pointerIndicaterRadius * 2, pointerIndicaterRadius * 2))
        self.model.progressColors[0].setFill()
        pointeRound.fill()
        // pointerTriangle
        let pointerTriangle = UIBezierPath()
        pointerTriangle.moveToPoint(CGPointMake(
            origin.x + self.model.pointerRadius * cos(endAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.model.pointerRadius * sin(endAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + pointerIndicaterRadius * cos((endAngular + 90) / 180.0 * CGFloat(M_PI)),
            origin.y + pointerIndicaterRadius * sin((endAngular + 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + pointerIndicaterRadius * cos((endAngular - 90) / 180.0 * CGFloat(M_PI)),
            origin.y + pointerIndicaterRadius * sin((endAngular - 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + self.model.pointerRadius * cos(endAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.model.pointerRadius * sin(endAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.closePath()
        self.model.progressColors[0].setFill()
        pointerTriangle.fill()
        self.model.progressColors[0].setStroke()
        pointerTriangle.lineWidth = 0
        pointerTriangle.stroke()
        
        
        // progress Set
        let progressSet = UIBezierPath()
        let progressSetAngular = (startAngle + (clockwise ? 1 : -1) * self.model.maxAngular * self.model.progressSetValue) / 180.0 * CGFloat(M_PI)
        progressSet.moveToPoint(CGPointMake(
            origin.x + (radius + self.model.circleWidth * 0.5) * cos(progressSetAngular),
            origin.y + (radius + self.model.circleWidth * 0.5) * sin(progressSetAngular)))
        progressSet.addLineToPoint(CGPointMake(
            origin.x + (radius - self.model.circleWidth * 0.5) * cos(progressSetAngular),
            origin.y + (radius - self.model.circleWidth * 0.5) * sin(progressSetAngular)))
        progressSet.closePath()
        self.model.progressSetColor.setFill()
        progressSet.fill()
        self.model.progressSetColor.setStroke()
        progressSet.lineWidth = 5
        progressSet.stroke()
        
        
        if self.drawedPercent < self.model.progress {
            self.drawedPercent = self.drawedPercent + 0.015
        } else {
            self.completeAnimation()
        }
    }
    
}






