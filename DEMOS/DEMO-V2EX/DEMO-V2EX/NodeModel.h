//
//  NodeModel.h
//  DEMO-V2EX
//
//  Created by CuiCui2 on 16/2/25.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "BaseModel.h"

@interface NodeModel : BaseModel
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *uid;  //id
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *title_alternative;
@property (nonatomic, copy) NSString *topics;
@property (nonatomic, copy) NSString *url;
@end
