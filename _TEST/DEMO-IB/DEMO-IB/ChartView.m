//
//  ChartView.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

//http://justsee.iteye.com/blog/1886463
//overwride: layoutSubViews, drawRect, sizeThatFits

//系统自动调用: addSubview, 设置frame, 滚动UIScrollView, 旋转Screen, 改变一个UIView大小 -> layoutSubViews

//手动调用:
//  setLayoutSubviews -> layoutSubViews
//  setNeedsLayout -> layoutIfNeeded -> 设置标记 -> layoutSubViews
//  layoutIfNeeded -> 判断标记 可能 -> layoutSubViews
//  sizeToFit -> sizeThatFits -> layoutSubViews
//  layoutSubViews  ->   可能    -> drawect
//  setNeedsDisplay ->  drawrect


#import "ChartView.h"
#import "PublicHeader.h"
#import "DEMO_IB-swift.h"

@interface ChartView()
@end

@implementation ChartView {
    UILabel *_noData;
    UIView *_chart;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColor.yellowColor;
    _noData = [[UILabel alloc] init];
    _noData.text = @"no Data";
    _noData.textColor = [[UIColor alloc] initWithWhite:0.3 alpha:1];
    _noData.font = [UIFont systemFontOfSize:15];
    [self addSubview:_noData];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _chart.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _noData.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [_noData sizeToFit];
}

- (void)setModel:(ChartModel *)model {
    if (_model.chartType != model.chartType) {
        [_chart removeFromSuperview];
         _chart = [ChartView chartViewWithType:model.chartType];
        [self addSubview:_chart];
    }
    if (_model != model) {
        _model = model;
        //config model for chart
    }
}

@end


@implementation ChartView (Factory)
+ (UIView *)chartViewWithType:(NSString *)chartType {
    if ([chartType isEqualToString:ChartTypePie]) {
        return [[PieChartView alloc] init];
    } else if ([chartType isEqualToString:ChartTypeWordle]) {
        return [[WordCloudView alloc] init];
    } else {
        return [[PieChartView alloc] init];
    }
    //...
}
@end


