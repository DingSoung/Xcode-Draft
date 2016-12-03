//
//  CustView.m
//  TryCatchView
//
//  Created by Songwen Ding on 12/3/16.
//  Copyright © 2016 DingSoung. All rights reserved.
//

#import "CustView.h"

@implementation CustView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(29, 36, 23, 23)];
    [UIColor.grayColor setFill];
    [ovalPath fill];
}

@end
