//
//  ViewController.h
//  testOC
//
//  Created by 丁松 on 15/3/10.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestModel;

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) TestModel * model;

@end

