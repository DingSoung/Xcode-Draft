//
//  ChartModel.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ChartModel.h"
#import "PublicHeader.h"

@implementation ChartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _chartType = ChartTypeDefault;
    }
    return self;
}

@end
