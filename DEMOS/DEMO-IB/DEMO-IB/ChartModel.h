//
//  ChartModel.h
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicHeader.h"

#define ChartTypeDefault    @"C200"
#define ChartTypePie        @"C201"
#define ChartTypeWordle     @"C202"

@interface ChartModel : NSObject
@property (nonatomic, copy) NSString  *chartType;
@end
