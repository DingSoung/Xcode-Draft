//
//  PieChatView.h
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartView.h"
#import "PieChartModel.h"

@interface PieChartView : ChartView
@property (nonatomic, copy) NSArray *pieChartModels;  //PieChartModel
@end
