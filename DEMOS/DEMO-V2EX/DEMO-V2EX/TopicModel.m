//
//  TopicModel.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    } else if ([key isEqualToString:@"member"]) {
        //NSDictionary *dict = value;
        //self.memberModel = [[MemberModel alloc] initWithDict:dict];
    } else if ([key isEqualToString:@"node"]) {
        //NSDictionary *dict = value;
        //self.nodeDetailModel = [[NodeDetailModel alloc] initWithDict:dict];
    } else {
        NSLog(@"undefined key%@:value%@",key,value);
    }
}

@end
