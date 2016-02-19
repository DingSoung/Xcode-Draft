//
//  PieChatView.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "PieChatView.h"

@implementation PieChatView

- (instancetype)init:(CGRect)frame sizeArray:(NSArray *)sizeArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.sizeArray = sizeArray;
        //....
    }
    return self;
}

//sepc http://www.iliunian.com/2346.html

- (void)drawRect:(CGRect)rect {
    if (self.sizeArray) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //颜色线条
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); //设置矩形填充颜色
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1); //设置画笔颜色
        CGContextSetLineWidth(context, 0.6); //设置画笔线条粗细
        
        //扇形参数
        CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5; //半径
        CGFloat startX = self.frame.size.width * 0.5; //圆心x坐标
        CGFloat startY = self.frame.size.height * 0.5; //圆心y坐标
        CGFloat startPercent = 0; //起始角度
        CGFloat capacityPercent = 0;  //增量角度
        int clockwise = 0; //0 = clockwise
        
        CGFloat totalSize = 0;
        for (NSUInteger index = 0; index < self.sizeArray.count; index++) {
            totalSize = totalSize + [(NSNumber *)[self.sizeArray objectAtIndex:index] floatValue];
        }
        CGFloat average = totalSize / self.sizeArray.count;
        
        for (NSInteger index = 0; index < self.sizeArray.count; index++) {
            // different color
            CGFloat red = [(NSNumber *)[self.sizeArray objectAtIndex:index] floatValue] / average;
            CGContextSetRGBStrokeColor(context, red * 0.5, red * 0.25, red * 0.25, 1); //设置画笔颜色
            CGContextSetRGBFillColor(context, red, red * 0.5, red * 0.5, 1); //设置矩形填充颜色
            
            // different size
            capacityPercent = [(NSNumber *)[self.sizeArray objectAtIndex:index] floatValue] / totalSize;
            
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
