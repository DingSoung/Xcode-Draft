//
//  WrodCloudPlacement.h
//  DEMO
//
//  Created by Alex D. on 12/9/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WrodCloudModel : NSObject

- (instancetype)initWithText: (NSString *)text color: (UIColor *)color wegiht: (CGFloat)weight;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) UIColor *color;
@property (nonatomic, assign) CGFloat weight;

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint center;

@end








@protocol WordCloudDelegate <NSObject>

@required //必须实现的方法
-(void)eat;

@optional //可选实现的方法
-(void)run;
-(void)say;
-(void)sleep;

@end

@interface WrodCloudPlacement : NSObject {
    id<WordCloudDelegate> delegate;
}

- (instancetype)initWithWrodCloudModels:(NSArray *)models forView:(UIView *)view;

@property (nonatomic, copy) NSArray *models;

@end

