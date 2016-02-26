//
//  MemberModel.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel
- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    } else {
        NSLog(@"undefined key%@:value%@",key,value);
    }
}
@end
