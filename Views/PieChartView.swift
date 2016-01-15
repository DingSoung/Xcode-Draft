//
//  PieChartView.swift
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class PieChartModel: NSObject {
    var text = ""
    var value:Double = 0.0
    var color = UIColor.whiteColor()
    
    convenience init(text:String, value: Double, color: UIColor) {
        self.init()
        self.text = text
        self.value = value
        self.color = color
    }
}

class PieChartView: UIView {
    var models:[PieChartModel] = []
    
    var lineWidth:CGFloat = 1.0
    var fillColor:UIColor = UIColor.brownColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        self.models = [PieChartModel(text: "1111", value: 121, color: UIColor.redColor()),
            PieChartModel(text: "222", value: 222, color: UIColor.greenColor()),
            PieChartModel(text: "333", value: 333, color: UIColor.blueColor()),
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let radius = min(self.frame.size.width, self.frame.size.height) * 0.5
        let origin = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)
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



/*

#import "PieChartView.h"
#import <DEMO_IB-swift.h>

@implementation PieChartView {
    CGFloat _lineWidth;
    UIColor *_fillColor;
    }
    
    - (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lineWidth = 1;
        _fillColor = UIColor.redColor;
        
    }
    return self;
    }
    
    - (void)setModel:(ChartModel *)model {
        [super setModel:model];
        
        PieChartModel *m = [[PieChartModel alloc] init];
        self.pieChartModels = @[m];
        }
        
        - (void)setPieChartModels:(NSArray *)pieChartModels {
            if (_pieChartModels != pieChartModels) {
                _pieChartModels = pieChartModels;
                
                //call drawect
                [self sizeToFit];
            }
            }
            
            - (void)drawRect:(CGRect)rect {
                [super drawRect:rect];
                if (_pieChartModels.count > 0) {
                    
                    
                    CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5; //半径
                    CGPoint origin = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5); //中心位置
                    
                    int clockwise = 0; //0 = clockwise
                    double startPercent = 0; //起始角度
                    double capacityPercent = 0;  //增量角度
                    double totalWeight = 0;
                    
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    CGContextSetLineWidth(context, _lineWidth); //设置画笔线条粗细
                    
                    for (NSInteger index = 0; index < _pieChartModels.count; index++) {
                        PieChartModel *model = [_pieChartModels objectAtIndex:index];
                        if (model == nil) {
                            break;
                        }
                        totalWeight = totalWeight + model.weight;
                    }
                    for (NSInteger index = 0; index < _pieChartModels.count; index++) {
                        PieChartModel *model = [_pieChartModels objectAtIndex:index];
                        if (model == nil) {
                            break;
                        }
                        
                        // different color
                        const CGFloat* strokeRGB = CGColorGetComponents(_fillColor.CGColor); //.....
                        CGContextSetRGBStrokeColor(context, strokeRGB[0], strokeRGB[1], strokeRGB[2], strokeRGB[3]); //设置画笔颜色
                        const CGFloat* fillRGB = CGColorGetComponents(_fillColor.CGColor);
                        CGContextSetRGBFillColor(context, fillRGB[0], fillRGB[1], fillRGB[2], fillRGB[3]); //设置矩形填充颜色
                        
                        // different size
                        capacityPercent = model.weight / totalWeight;
                        
                        // deaw arc
                        CGContextMoveToPoint(context, origin.x, origin.y);  //设置起点
                        CGContextAddArc(context, origin.x, origin.y, radius, startPercent * 2 * M_PI, (startPercent + capacityPercent) * 2 * M_PI, clockwise); //绘制
                        CGContextClosePath(context); //关闭起点和终点
                        CGContextDrawPath(context, kCGPathEOFillStroke); //渲染
                        
                        // net step
                        startPercent = startPercent + capacityPercent;
                    }
                }
}*/

