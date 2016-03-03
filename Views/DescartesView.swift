//
//  DescartesView.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 3/3/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
class DescartesView: UIView {
    var lineWidth:CGFloat = 3
    var lineColor:UIColor = UIColor.redColor()
    var fillColor:UIColor = UIColor.clearColor()
    
    var animationDuration:CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
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
    
    
    private var displayLink:CADisplayLink?
    private var drawedPercent:CGFloat = 0
    private func startAnimation() {
        self.drawedPercent = 0
        
        self.displayLink = CADisplayLink(target: self, selector: "tickAnimation")
        self.displayLink?.frameInterval = 1
        self.displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    private func completeAnimation() {
        self.displayLink?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
    func tickAnimation() {
        self.setNeedsDisplay()
    }
    
    //x = 16 * sin(t)^3
    //y = 13 * cos(t) - 5* cos(2*t) - 2 * cos(3*t) - cos(4*t)
    //width : height = 32 : 29
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let radius = min((rect.size.width - 2 * self.lineWidth) / 32.0, (rect.size.height - 2 * self.lineWidth) / 29.0)
        let origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.42)
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(origin.x, origin.y - radius))
        for (var angular = 0; angular < Int(self.drawedPercent); angular++) {
            
            let a = CGFloat(angular) / 180.0 * CGFloat(M_PI)
            let x = 16 * pow(sin(a), 3)
            var y = 13 * cos(a) - 5 * cos(2 * a) - 2 * cos(3 * a)
            y = y - cos(4 * a)
            y = y * -1
            path.addLineToPoint(CGPointMake(
                origin.x + radius * x,
                origin.y + radius * y))
        }
        //path.closePath()
        
        self.fillColor.setFill()
        path.fill()
        self.lineColor.setStroke()
        path.lineWidth = self.lineWidth
        path.stroke()
        
        if self.drawedPercent < 360 {
            self.drawedPercent = self.drawedPercent + ((1/60) / self.animationDuration) * 360
        } else {
            self.completeAnimation()
        }
    }
    
}