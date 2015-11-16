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
        
        /*
        CGContextSetRGBStrokeColor(context, 1, 1.0, 1.0, 1.0);
        CGContextSetLineWidth(context, 2.0);
        CGContextAddRect(context, CGRectMake(2, 2, 270, 270));
        CGContextStrokePath(context);
        
        //画方形背景颜色
        CGContextTranslateCTM(context, 0.0f, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0f, -1.0f);
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context,320);
        CGContextSetRGBStrokeColor(context, 250.0/255, 250.0/255, 210.0/255, 1.0);
        CGContextStrokeRect(context, CGRectMake(0, 0, 320, 460));
        UIGraphicsPopContext();
        
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
        CGContextAddArc(context, 100, 100, 50, 180* M_PI/ 180, 270* M_PI/ 180,0); CGContextStrokePath(context);
        
        //椭圆
        CGRect aRect= CGRectMake(80, 80, 160, 100);
        CGContextSetRGBStrokeColor(context, 0.6, 0.9, 0, 1.0);
        CGContextSetLineWidth(context, 3.0);
        // CGContextSetFillColorWithColor(context, aColor.CGColor);
        // CGContextAddRect(context, rect); //矩形
        CGContextAddEllipseInRect(context, aRect); //椭圆
        CGContextDrawPath(context, kCGPathStroke);
        
        */
        
        
        
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); //设置矩形填充颜色
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1); //设置画笔颜色
        CGContextSetLineWidth(context, 0.6); //设置画笔线条粗细
        
        //扇形参数
        CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5; //半径
        int startX = self.frame.size.width * 0.5; //圆心x坐标
        int startY = self.frame.size.height * 0.5; //圆心y坐标
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
            
            //deaw arc
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddArc(context, startX, startY, radius, startPercent * 2 * M_PI, (startPercent + capacityPercent) * 2 * M_PI, clockwise);
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathEOFillStroke);
            
            startPercent = startPercent + capacityPercent;
        }
        
        
        
        
        
        
        
        
        /*
        
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);//设置矩形填充颜色
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);//设置画笔颜色
        CGContextSetLineWidth(context, 0.6); //设置画笔线条粗细
        
        CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5;  //半径
        CGFloat startAngle = 0; //起始角度
        CGFloat capacityAngle = 0;  //增量角度
        int clockwise=1;//0=逆时针,1=顺时针
        
        capacityAngle = 60 ;//[(NSNumber *)[self.sizeArray objectAtIndex:1] floatValue] / totalSize * M_PI;
        
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, radius, startAngle,startAngle + capacityAngle, clockwise);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathEOFillStroke);
        
        
        
        startAngle = startAngle + capacityAngle;
        
        CGFloat totalSize = 0;
        for (NSUInteger index = 0; index < self.sizeArray.count; index++) {
            NSNumber * size = (NSNumber *)[self.sizeArray objectAtIndex:1];
            totalSize = totalSize + size.floatValue;
        }
        
        for (NSInteger index = 0; index < self.sizeArray.count; index++) {
        }*/
        
    }
}

@end
