//
//  PieChatView.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

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
}

@end
