//
//  Singletons.h
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singletons : NSObject {
    NSString *someProperty; //这种属性在super init之前初始化
}

@property (nonatomic, retain) NSString *someProperty;

+ (id)instance;

-(NSString *) func1:(NSString *) inputer times:(NSString *) times;

-(void) func2: (NSString * )url
    parameter: (NSDictionary *)parameter
      success: (void (^)(id data))success
         fail: (void (^)(NSError * error))fail;

@end
