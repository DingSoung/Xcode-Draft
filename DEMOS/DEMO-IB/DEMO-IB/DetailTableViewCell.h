//
//  DetailTableViewCell.h
//  DEMO-IB
//
//  Created by Alex D. on 1/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailModel.h"

@interface DetailTableViewCell : UITableViewCell
@property (nonatomic, copy) DetailModel *model;
@end
