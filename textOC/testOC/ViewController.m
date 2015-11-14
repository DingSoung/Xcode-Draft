//
//  ViewController.m
//  testOC
//
//  Created by 丁松 on 15/3/10.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TestView * testView = [[TestView alloc] init];
    CGRect frame = testView.frame;  //真烂啊  swift里面一行搞定  在这里要三行
    frame.size = CGSizeMake(150, 250);
    testView.frame = frame;
    testView.center = self.view.center;   //每次都要打分号  晕
    [self.view addSubview:testView];
    
    [TestView testFunction1];
    [TestView testFunction2:@"ubduysfub"];
    NSLog(@"%@", [TestView testFunction3:@"shshshshs" times:3]);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/**
 明天:
 
 写属性   属性的种类
 
 写对象的方法
 
 写单例
 
 写model init
 
 写 Xib 和 OC
 写StoryBoard 和 OC
 
 */




