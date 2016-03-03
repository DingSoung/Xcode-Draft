//
//  GuageChartView.swift
//  MCompass
//
//  Created by Alex D. on 3/1/16.
//  Copyright © 2016 haizhi. All rights reserved.
//

import UIKit

public class GaugeChartView: UIView {
    
    public var title = "hahahah";
    public var detail = "9829";
    
    public var animationDuration:CGFloat = 0.8
    public var maxAngular:CGFloat = 200.0;
    
    public var progressValve:CGFloat = 0.2;
    public var progressColor = UIColor.orangeColor()
    public var progressBackEndColor = UIColor.grayColor()
    public var progressWidth:CGFloat = 20;
    
    public var progressBackColor = UIColor.lightGrayColor()
    public var progressBackWidth:CGFloat = 25;
    
    public var progressSetValues:[CGFloat] = []
    public var progressSetColors:[UIColor] = []
    
    
    
    public var pointerRadius:CGFloat = 35;
    
    
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
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.startAnimation()
    }
    
    deinit {
        self.completeAnimation()
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let origin = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5)
        let radius = min(rect.size.width, rect.size.height) * 0.5 - self.progressBackWidth * 0.5;
        
        let clockwise = true
        let startAngle:CGFloat = (clockwise ? -1 : 1) * ((180.0 - self.maxAngular) * 0.5 + self.maxAngular);
        
        // progress background
        let progressBack = UIBezierPath()
        progressBack.lineCapStyle = CGLineCap.Round
        progressBack.addArcWithCenter(origin, radius: radius,
            startAngle: startAngle / 180.0 * CGFloat(M_PI),
            endAngle: (startAngle + (clockwise ? 1 : -1) * self.maxAngular * 1.0000000) / 180.0 * CGFloat(M_PI),
            clockwise: clockwise)
        self.progressBackColor.setStroke()
        progressBack.lineWidth = self.progressBackWidth;
        progressBack.stroke()
        
        // pointer background
        let pointerBackground = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - self.pointerRadius, rect.size.height * 0.5 - self.pointerRadius, self.pointerRadius * 2, self.pointerRadius * 2))
        self.progressBackColor.setFill()
        pointerBackground.fill()
        
        let endAngular:CGFloat = startAngle + (clockwise ? 1 : -1) * self.maxAngular * self.drawedPercent
        
        // progress
        let progress = UIBezierPath()
        progress.lineCapStyle = CGLineCap.Round
        progress.addArcWithCenter(origin, radius: radius,
            startAngle: startAngle / 180.0 * CGFloat(M_PI),
            endAngle: endAngular / 180.0 * CGFloat(M_PI),
            clockwise: clockwise)
        self.progressColor.setStroke()
        progress.lineWidth = self.progressWidth;
        progress.stroke()
        
        // progress End
        let progressEndRadius = self.progressWidth * 0.5 * 0.5
        let progressEnd = UIBezierPath(ovalInRect: CGRectMake(
            origin.x + radius * cos(endAngular / 180.0 * CGFloat(M_PI)) - progressEndRadius,
            origin.y + radius * sin(endAngular / 180.0 * CGFloat(M_PI)) - progressEndRadius,
            progressEndRadius * 2, progressEndRadius * 2))
        self.progressBackEndColor.setFill()
        progressEnd.fill()
        
        
        let pointerIndicaterRadius = self.pointerRadius * 0.8;
        // pointerPad
        let pointeRound = UIBezierPath(ovalInRect: CGRectMake(rect.size.width * 0.5 - pointerIndicaterRadius, rect.size.height * 0.5 - pointerIndicaterRadius, pointerIndicaterRadius * 2, pointerIndicaterRadius * 2))
        self.progressColor.setFill()
        pointeRound.fill()
        
        // pointerTriangle
        let pointerTriangle = UIBezierPath()
        pointerTriangle.moveToPoint(CGPointMake(
            origin.x + self.pointerRadius * cos(endAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * sin(endAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + pointerIndicaterRadius * cos((endAngular + 90) / 180.0 * CGFloat(M_PI)),
            origin.y + pointerIndicaterRadius * sin((endAngular + 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + pointerIndicaterRadius * cos((endAngular - 90) / 180.0 * CGFloat(M_PI)),
            origin.y + pointerIndicaterRadius * sin((endAngular - 90) / 180.0 * CGFloat(M_PI))))
        pointerTriangle.addLineToPoint(CGPointMake(
            origin.x + self.pointerRadius * cos(endAngular / 180.0 * CGFloat(M_PI)),
            origin.y + self.pointerRadius * sin(endAngular / 180.0 * CGFloat(M_PI))))
        pointerTriangle.closePath()
        self.progressColor.setFill()
        pointerTriangle.fill()
        self.progressColor.setStroke()
        pointerTriangle.lineWidth = 0
        pointerTriangle.stroke()
        
        
        // progress Set
        for (var index = 0; index < self.progressSetValues.count && index < self.progressSetColors.count; index++) {
            let progressSet = UIBezierPath()
            let progressSetAngular = (startAngle + (clockwise ? 1 : -1) * self.maxAngular * self.progressSetValues[index]) / 180.0 * CGFloat(M_PI)
            progressSet.moveToPoint(CGPointMake(
                origin.x + (radius + self.progressBackWidth * 0.5) * cos(progressSetAngular),
                origin.y + (radius + self.progressBackWidth * 0.5) * sin(progressSetAngular)))
            progressSet.addLineToPoint(CGPointMake(
                origin.x + (radius - self.progressBackWidth * 0.5) * cos(progressSetAngular),
                origin.y + (radius - self.progressBackWidth * 0.5) * sin(progressSetAngular)))
            progressSet.closePath()
            self.progressSetColors[index].setFill()
            progressSet.fill()
            self.progressSetColors[index].setStroke()
            progressSet.lineWidth = 2
            progressSet.stroke()
        }
        
        //TextSet
        let context = UIGraphicsGetCurrentContext()
        //let textRect = CGRectMake(21, 17, 135, 45)
        //var textTextContent = NSString(string: "Hello, World!")
        let kFontSize = self.pointerRadius / CGFloat(max(self.title.characters.count, 1)) * 2.5
        let kTextSize = (self.title as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(kFontSize)])
        let textRect = CGRectMake(origin.x - kTextSize.width * 0.5, origin.y - kTextSize.height * 0.5, kTextSize.width, kTextSize.height)
        let textTextContent = NSString(string: self.title)
        
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(kFontSize), NSForegroundColorAttributeName: UIColor.whiteColor(), NSParagraphStyleAttributeName: textStyle]
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        textTextContent.drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        
        let context2 = UIGraphicsGetCurrentContext()
        let kFontSize2:CGFloat = 11 //self.pointerRadius / CGFloat(max(self.detail.characters.count, 1)) * 2.5
        let kTextSize2 = (self.detail as NSString).sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(kFontSize2)])
        let textRect2 = CGRectMake(
            origin.x + radius * cos((startAngle + (clockwise ? 1 : -1) * self.maxAngular) / 180.0 * CGFloat(M_PI)) - kTextSize2.width * 0.5,
            origin.y + radius * sin((startAngle + (clockwise ? 1 : -1) * self.maxAngular) / 180.0 * CGFloat(M_PI)) - kTextSize2.height * 0.5 + self.progressBackWidth,
            kTextSize2.width, kTextSize2.height)
        let textTextContent2 = NSString(string: self.detail)
        
        let textStyle2 = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle2.alignment = NSTextAlignment.Center
        let textFontAttributes2 = [NSFontAttributeName: UIFont.systemFontOfSize(kFontSize2), NSForegroundColorAttributeName: UIColor.grayColor(), NSParagraphStyleAttributeName: textStyle2]
        let textTextHeight2: CGFloat = textTextContent2.boundingRectWithSize(CGSizeMake(textRect2.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes2, context: nil).size.height
        CGContextSaveGState(context2)
        CGContextClipToRect(context2, textRect2);
        textTextContent2.drawInRect(CGRectMake(textRect2.minX, textRect2.minY + (textRect2.height - textTextHeight2) / 2, textRect2.width, textTextHeight2), withAttributes: textFontAttributes2)
        CGContextRestoreGState(context2)
        
        if self.drawedPercent < self.progressValve {
            self.drawedPercent = self.drawedPercent + (1/60) / self.animationDuration * self.progressValve
        } else {
            self.completeAnimation()
        }
    }
}
