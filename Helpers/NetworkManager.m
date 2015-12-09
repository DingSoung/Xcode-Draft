//
//  NetworkManager.m
//  MCompass
//
//  Created by D.Alex on 11/27/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkRequest

- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval startTime:(NSTimeInterval)startTime
{
    self = [super initWithURL:URL cachePolicy:cachePolicy timeoutInterval:timeoutInterval];
    if (self) {
        _startTime = startTime;
        _requestTimes = 0;
    }
    return self;
}
@end


@implementation NetworkManager {
    NSURLSession * _session;
}

+ (id)instance {
    static NetworkManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _session = [NSURLSession sharedSession];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

/**
 网络请求fail逻辑:
 1. 或者网络不可用
 2. 或者请求时间达60秒
 3. 或者网络连接错误5次以上
 */
- (void) processRequest:(NetworkRequest *)request success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail {
    NSURLSessionDataTask * task = [_session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error == nil) {
            success(data);
        } else {
            if (request.requestTimes++ >= 5) {
                fail(error);
            } else if ([[NSDate date] timeIntervalSince1970] >= request.startTime + 60) {
                fail(error);
            } else {
                [self processRequest:request success:success fail:fail]; //request self
            }
        }
    }];
    [task resume];
}

- (void) request:(NSString *)httpMethod url:(NSString *)url parameter:(NSData *)parameter success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail {
    /*if ([AFNetworkReachabilityManager sharedManager].reachable != YES) {
     NSError * error = [[NSError alloc] initWithDomain:@"当前网络不可用" code:-1 userInfo:nil];
     fail(error);
     return;
     }*/
    
    if ([httpMethod isEqualToString:@"GET"]) {
        //string series parameter and append to url
    }
    
    NSURL * URL = [[NSURL alloc] initWithString:url];
    if (URL == nil) {
        NSError * error = [[NSError alloc] initWithDomain:@"error url" code:-1 userInfo:@{}];
        fail(error);
        return;
    }
    
    NetworkRequest * request =  [[NetworkRequest alloc] initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20 startTime:[[NSDate date] timeIntervalSince1970]];
    if ([httpMethod isEqualToString:@"POST"]) {
        request.HTTPMethod = httpMethod;
        request.HTTPBody = parameter;
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    [self processRequest:request success:success fail:fail];
}

- (void) POST:(NSString *)url parameter:(NSData *)parameter success: (void (^)(NSData * data))success fail: (void (^)(NSError * error))fail {
    [self request: @"POST" url:url parameter:parameter success:success fail:fail];
}

@end

