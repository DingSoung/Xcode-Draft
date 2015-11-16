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
        
        
        CGFloat radius = MIN(self.frame.size.height, self.frame.size.width) * 0.5;
        
        
        CGFloat totalSize = 0;
        for (NSUInteger index = 0; index < self.sizeArray.count; index++) {
            NSNumber * size = (NSNumber *)[self.sizeArray objectAtIndex:1];
            totalSize = totalSize + size.floatValue;
        }
        
        
        CGFloat startAngle = 0;
        CGFloat endAngle = 10;
        for (NSInteger index = 0; index < self.sizeArray.count; index++) {
            
            CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
            CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5); //color
            
            endAngle = startAngle + [(NSNumber *)[self.sizeArray objectAtIndex:1] floatValue] / totalSize * M_PI;
            CGContextAddArc(context, self.center.x, self.center.y, radius, startAngle, endAngle, 0);
            startAngle = endAngle;
        }
    }
}

@end
