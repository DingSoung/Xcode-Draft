//
//  PieChatView.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "PieChartView.h"
#import <DEMO-swift.h>

@implementation PieChartView

- (instancetype)init:(CGRect)frame sizeArray:(NSArray *)sizeArray {
    self = [super initWithFrame:frame];
    if (self) {
        //default style
        _pieArray = sizeArray;
        [self configDefault];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        //[self configDefault];
    }
    return self;
}

- (void)configDefault {
    _pieArray = _pieArray.count > 0 ? _pieArray : @[@1];
    _fillColor = _fillColor != nil ? _fillColor : [[UIColor alloc] initWithRed:1 green:0 blue:0 alpha:1];
    _lineColor = _lineColor != nil ? _lineColor : [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1];
    _lineWidth = _lineWidth > 0 ? _lineWidth : 0.6;
}

- (void)setPieArray:(NSArray *)pieArray {
    _pieArray = pieArray;
    [self sizeToFit];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (_pieArray.count > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat totalSize = 0;
        for (NSUInteger index = 0; index < _pieArray.count; index++) {
            totalSize = totalSize + [(NSNumber *)[_pieArray objectAtIndex:index] floatValue];
        }
        CGFloat average = totalSize / _pieArray.count;
        
        CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5; //半径
        CGFloat startX = self.frame.size.width * 0.5; //圆心x坐标
        CGFloat startY = self.frame.size.height * 0.5; //圆心y坐标
        CGFloat startPercent = 0; //起始角度
        CGFloat capacityPercent = 0;  //增量角度
        int clockwise = 0; //0 = clockwise
        
        CGContextSetLineWidth(context, _lineWidth); //设置画笔线条粗细
        for (NSInteger index = 0; index < _pieArray.count; index++) {
            // different color
            CGFloat weight = ABS([(NSNumber *)[_pieArray objectAtIndex:index] floatValue] - average) / average;
            CGContextSetRGBStrokeColor(context,
                                       weight * _fillColor.coreImageColor.red,
                                       weight * _fillColor.coreImageColor.green,
                                       weight * _fillColor.coreImageColor.blue,
                                       _fillColor.coreImageColor.alpha); //设置画笔颜色
            CGContextSetRGBFillColor(context,
                                     weight * _fillColor.coreImageColor.red,
                                     weight * _fillColor.coreImageColor.green,
                                     weight * _fillColor.coreImageColor.blue,
                                     weight * _fillColor.coreImageColor.alpha); //设置矩形填充颜色
            // different size
            capacityPercent = [(NSNumber *)[_pieArray objectAtIndex:index] floatValue] / totalSize;
            
            // deaw arc
            CGContextMoveToPoint(context, startX, startY);  //设置起点
            CGContextAddArc(context, startX, startY, radius, startPercent * 2 * M_PI, (startPercent + capacityPercent) * 2 * M_PI, clockwise); //绘制
            CGContextClosePath(context); //关闭起点和终点
            CGContextDrawPath(context, kCGPathEOFillStroke); //渲染
            
            // net step
            startPercent = startPercent + capacityPercent;
        }
    }
}

@end
