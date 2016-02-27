//
//  MemberModel.h
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "BaseModel.h"

@interface MemberModel : BaseModel
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *avatar_mini;
@property (nonatomic, copy) NSString *avatar_normal;
@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *tagline;
@property (nonatomic, copy) NSString *username;
@end
