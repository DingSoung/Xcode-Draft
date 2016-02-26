//
//  ReplyModel.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "ReplyModel.h"

@implementation ReplyModel
- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    }else if ([key isEqualToString:@"member"]) {
        NSDictionary *dict = value;
        _memberModel = [[MemberModel alloc] initWithDict:dict];
    } else {
        NSLog(@"undefined key%@:value%@",key,value);
    }
}
@end
