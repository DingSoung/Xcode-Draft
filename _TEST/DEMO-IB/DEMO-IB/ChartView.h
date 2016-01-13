//
//  ChartView.h
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartModel.h"

IB_DESIGNABLE
@interface ChartView : UIView
@property (weak, nonatomic) IBOutlet UILabel *noData;
@property (nonatomic, copy) ChartModel *model;
//IBInspectable
@end

