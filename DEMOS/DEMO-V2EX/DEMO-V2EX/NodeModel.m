//
//  NodeModel.m
//  DEMO-V2EX
//
//  Created by CuiCui2 on 16/2/25.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "NodeModel.h"

@implementation NodeModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    } else {
        NSLog(@"undefined key%@:value%@",key,value);
    }
}

@end
