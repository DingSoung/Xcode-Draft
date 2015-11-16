//
//  TestSpringView.h
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSpringView : UIView

- (instancetype)init:(CGRect)frame backColor:(UIColor *)backColor frontColor:(UIColor *)frontColor percent:(CGFloat)percent;

@property (nonatomic, strong) UIView * frontView;
@property (nonatomic, assign) CGFloat percent;


-(void)setPercent:(CGFloat)percent;
@end
