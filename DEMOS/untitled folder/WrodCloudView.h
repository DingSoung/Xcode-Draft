//
//  WordleView.h
//  DEMO
//
//  Created by D.Alex on 12/3/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WrodCloudModel.h"

@interface WrodCloudView : UIView

@property (nonatomic, copy) NSArray *models;

- (instancetype)initWithFrame:(CGRect)frame WrodCloudModels:(NSArray *)models;

@end
