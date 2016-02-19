//
//  TestSpringView.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestSpringView.h"

@implementation TestSpringView


- (instancetype)init:(CGRect)frame backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor percent:(CGFloat)percent
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = backColor;
        
        self.frontView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        self.frontView.backgroundColor = frontColor;
        [self addSubview:self.frontView];
        
        self.percent = percent;
    }
    return self;
}


-(void)setPercent:(CGFloat)percent {
    
    _percent = percent;
    
    [UIView animateWithDuration:0.3 delay:3 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //...
        
        CGRect frame = self.frontView.frame;
        frame.size.height = self.frame.size.height * self.percent / 100.0;
        frame.origin.y = self.frame.size.height - frame.size.height;
        self.frontView.frame = frame;
    } completion:^(BOOL finished) {
        //...
        NSLog(@"new percent is %d", _percent);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
