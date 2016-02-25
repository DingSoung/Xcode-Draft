//
//  GaugeChartView.swift
//  DEMO-CoreGraph
//
//  Created by Alex D. on 2/22/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class GaugeChartView: UIView {
    
    var maxAngular = 120.0;
    var circleWidth:CGFloat = 20;
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.yellowColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        // R - sign(90 - maxAngular * 0.5) * R < totalHeight - circleWidth
        // R * cos(90 - maxAngular * 0.5) * 2 < totalWidth - circleWidth
        let minR1 = (self.frame.size.height - self.circleWidth) / (1 - cos(CGFloat(maxAngular) * 0.5))
        let minR2 = (self.frame.size.width - self.circleWidth) / (2 * (1 - sin(CGFloat(maxAngular) * 0.5)))
        let radius = min(minR1, minR2)
        
        
        let origin = CGPointMake(self.center.x, self.circleWidth * 0.5 + radius)
        
        let clockwise = true
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

}






