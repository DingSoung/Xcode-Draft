//
//  ChartDetailViewController.h
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChartModel.h"

@interface VCModel : NSObject
@property (nonatomic, copy) ChartModel *chartModel;
//...
@end

@interface ChartDetailViewController : UIViewController
- (void)pushChartWithModel:(VCModel *)model;
- (void)popChartsWithCount:(NSInteger)count;
@end
