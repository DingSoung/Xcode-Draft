//
//  NodeDetailModel.h
//  DEMO-V2EX
//
//  Created by Alex D. on 16/2/26.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "BaseModel.h"

@interface NodeDetailModel : BaseModel
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *avatar_mini;
@property (nonatomic, copy) NSString *avatar_normal;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_alternative;
@property (nonatomic, copy) NSString *topics;
@property (nonatomic, copy) NSString *url;
@end
