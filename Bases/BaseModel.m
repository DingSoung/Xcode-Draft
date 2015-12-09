//
//  BaseModel.m
//  MCompass
//
//  Created by D.Alex on 11/23/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

#pragma mark - dict to model

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithJsonStr: (NSString *)JsonStr {
    self = [super init];
    if (self) {
        NSData * JsonData = [JsonStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSError * error;
        NSDictionary * JsonDict = [NSJSONSerialization JSONObjectWithData:JsonData options:NSJSONReadingMutableContainers error:&error];
        if (error == nil) {
            [self setValuesForKeysWithDictionary:JsonDict];
        }
    }
    return self;
}

- (instancetype)initWithJsonDict: (NSDictionary *)JsonDict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:JsonDict];
    }
    return self;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
#ifdef DEBUG
    NSLog(@"undefined key%@:value%@",key,value);
#endif
    //override this func to deal with the key and value
}

@end
