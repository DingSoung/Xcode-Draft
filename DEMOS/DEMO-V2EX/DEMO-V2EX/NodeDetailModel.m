//
//  NodeDetailModel.m
//  DEMO-V2EX
//
//  Created by Alex D. on 16/2/26.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "NodeDetailModel.h"

@implementation NodeDetailModel
- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    } else {
        NSLog(@"undefined key%@:value%@",key,value);
    }
}
@end
