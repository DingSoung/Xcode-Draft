//
//  Singletons.m
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "Singletons.h"

@implementation Singletons {
    NSString * someString;
}

@synthesize someProperty;

#pragma mark Singleton Methods

//使用CGD获取唯一本身 确保线程安全
+ (id)instance {
    static Singletons *sharedMyManager = nil;  //static  确保只有一个
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.someProperty = @"Default Property Value";
        self->someString = @"some string";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


-(NSString *) func1:(NSString *) inputer times:(NSString *) times {
    return [inputer stringByAppendingString:times];
}


-(void) func2: (NSString *)url
    parameter: (NSDictionary *)parameter
      success: (void (^)(id data))success
         fail: (void (^)(NSError * error))fail {
    
    if (url.length > 0) {
        success([[NSData alloc]init]);
    } else {
        fail([[NSError alloc] initWithDomain:@"url wrong" code:-1 userInfo:nil]);
    }
}

@end
