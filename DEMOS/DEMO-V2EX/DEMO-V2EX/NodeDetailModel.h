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
/// tipic model 下的NodeDetail 没有
@property (nonatomic, copy) NSString *created;
/// tipic model 下的NodeDetail 没有
@property (nonatomic, copy) NSString *footer;
/// tipic model 下的NodeDetail 没有
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *name;
/// tipic model 下的NodeDetail 没有
@property (nonatomic, copy) NSString *stars;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_alternative;
@property (nonatomic, copy) NSString *topics;
@property (nonatomic, copy) NSString *url;

/// 带
@end
