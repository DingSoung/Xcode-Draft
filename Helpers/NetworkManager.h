//
//  NetworkManager.h
//  MCompass
//
//  Created by D.Alex on 11/27/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSMutableURLRequest
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSInteger requestTimes;
@end

@interface NetworkManager : NSObject

+ (id)instance;

- (void) processRequest:(NetworkRequest *)request success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail;
- (void) request:(NSString *)httpMethod url:(NSString *)url parameter:(NSData *)parameter success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail;
- (void) POST:(NSString *)url parameter:(NSData *)parameter success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail;

@end
