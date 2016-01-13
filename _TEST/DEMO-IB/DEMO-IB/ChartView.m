//
//  ChartView.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ChartView.h"
#import "PublicHeader.h"
#import "DEMO_IB-swift.h"

@interface ChartView()
@end

@implementation ChartView {
    UILabel *_noData;
    UIView *_chartView;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        _noData = [[UILabel alloc] init];
        _noData.text = @"no Data";
        _noData.textColor = [[UIColor alloc] initWithWhite:0.3 alpha:1];
        _noData.font = [UIFont systemFontOfSize:15];
        [self addSubview:_noData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_noData sizeToFit];
    _noData.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)setModel:(ChartModel *)model {
    if (_model != model) {
        _model = model;
    }
}

@end


@implementation ChartView (Factory)
+ (UIView *)chartViewWithType:(NSString *)chartType {
    if ([chartType isEqualToString:ChartTypeDefault]) {
        return [[PieChartView alloc] init];
    } else {
        return [[PieChartView alloc] init];
    }
}
@end



