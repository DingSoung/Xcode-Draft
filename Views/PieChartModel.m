//
//  PieChartModel.m
//  DEMO
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "PieChartModel.h"

@implementation PieChartModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.text = @"hello";
        self.weight = 1;
        self.colorHex8 = @"#88AA00EE";
    }
    return self;
}

@end
