//
//  BaseModel.h
//  MCompass
//
//  Created by D.Alex on 11/23/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)init;
- (instancetype)initWithJsonStr: (NSString *)JsonStr ;
- (instancetype)initWithJsonDict: (NSDictionary *)JsonDict;

@end
