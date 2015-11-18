//
//  ViewController.m
//  testOC
//
//  Created by 丁松 on 15/3/10.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "TestModel.h"
#import "Singletons.h"
#import "TestXib.h"
#import "TestSpringView.h"
#import "PieChatView.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *section;




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
    NSLog(@"func2 %@",[TestView testFunction2:@"ubduysfub"]);
    NSLog(@"func3 %@", [TestView testFunction3:@"shshshshs" times:3]);
    
    NSLog(@"%ld", testView.times);
    NSLog(@"%d", testView.isFirstTime);
    NSLog(@"%@", testView.str);
    
    NSLog(@"func 4 %@", [testView testFunc4:@"hahahahaha" times:4]);
    NSLog(@"%ld", testView.times);
    
    // Do any additional setup after loading the view, typically from a nib.
    
    Singletons * singletons = [[Singletons alloc] init];  //能初始化 但不能访问内部函数
    [[Singletons instance] func1:@"fefeefe" times:@"hhhhhhh"];
    
    [[Singletons instance] func2:@"www.baidu.com" parameter:@{@"key": @{@"subKey":@"subValue"}} success:^(id data) {
        //....
    } fail:^(NSError *error) {
        NSLog(@"%@", error.domain);
    }];
    
    
    TestXib * xibView = [[NSBundle mainBundle] loadNibNamed:@"TestXib" owner:self options:nil].firstObject;
    if (xibView) {
        [self.view addSubview:xibView];
    }
    
    
    TestSpringView * percent = [[TestSpringView alloc] init:CGRectMake(0, 0, 50, 100) backColor:UIColor.grayColor frontColor:UIColor.yellowColor percent:10];
    [self.view addSubview:percent];
    percent.percent = 50;
    
    NSArray *array = @[@1, @2, @3, @4, @5, @6];
    PieChatView * chart = [[PieChatView alloc] init:CGRectMake(self.view.frame.size.width - 200, 0, 200, 180) sizeArray:array];
    [self.view addSubview:chart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/**
 明天:
 
 写属性   属性的种类
 
 写单例
 
 写model init
 
 写 Xib 和 OC
 写StoryBoard 和 OC
 
 */




