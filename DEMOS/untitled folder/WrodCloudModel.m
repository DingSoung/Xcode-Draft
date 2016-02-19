//
//  WrodCloudPlacement.m
//  DEMO
//
//  Created by Alex D. on 12/9/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "WrodCloudModel.h"

@implementation WrodCloudModel

- (instancetype)initWithText: (NSString *)text color: (UIColor *)color wegiht: (CGFloat)weight {
    self = [super init];
    if (self) {
        _text = text;
        _color = color;
        _weight = weight;
    }
    return self;
}

- (NSString *)text {
    if (_text == nil) {
        return @"";
    } else {
        return _text;
    }
}

- (UIColor *)color {
    if (_color == nil) {
        return UIColor.whiteColor;
    } else {
        return _color;
    }
}

@end





@implementation WrodCloudPlacement


- (instancetype)initWithWrodCloudModels:(NSArray *)models forView:(UIView *)view {
    self = [super init];
    if (self) {
        
        _models = models;
        
        
        
        
        
        
        
    }
    return self;
}

/**
* 从 View 的中心为起始坐标
* 该坐标两个垂直方向空白空间的距离需要同时大于Label 的宽高,满足则取空白空间的中心位置放置 Label.
* 如果不满足,旋转坐标一定的角度,再次判断前面的条件,直到累计角度大于等于180度
* 以 Label 的最小边距为单位,平移,再次循环上面的步骤,如果不满足,则以单位长度,按弧度移动,如果移动的弧度大于等于360度,则再次平移,再次循环前面的步骤
* 如果循环360度都超出布局范围,终止所有循环
 */


@end
