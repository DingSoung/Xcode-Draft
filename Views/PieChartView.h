//
//  PieChatView.h
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PieChartView : UIView

@property (nonatomic, copy) NSArray *pieArray;
@property (nonatomic, copy) IBInspectable UIColor *fillColor;
@property (nonatomic, copy) IBInspectable UIColor *lineColor;
@property (nonatomic, assign) IBInspectable CGFloat lineWidth;

- (instancetype)init:(CGRect)frame sizeArray:(NSArray *)sizeArray;

@end
