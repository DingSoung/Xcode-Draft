//
//  PieChatView.h
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChatView : UIView

@property (nonatomic, copy) NSArray * sizeArray;

- (instancetype)init:(CGRect)frame sizeArray:(NSArray *)sizeArray;

@end
