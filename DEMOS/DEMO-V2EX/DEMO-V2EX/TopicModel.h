//
//  TopicModel.h
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "BaseModel.h"
#import "MemberModel.h"
#import "NodeDetailModel.h"

@interface TopicModel : BaseModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *content_rendered;
@property (nonatomic, copy) NSNumber *created;
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSNumber *last_modified;
@property (nonatomic, copy) NSNumber *last_touched;
@property (nonatomic, copy) MemberModel *memberModel;
@property (nonatomic, copy) NodeDetailModel *nodeDetailModel;
@property (nonatomic, copy) NSString *replies;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@end
