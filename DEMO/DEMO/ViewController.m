//
//  ViewController.m
//  DEMO
//
//  Created by Alex D. on 3/25/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "ViewController.h"
#import "DEMO-swift.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CCTabbar *tabbar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabbar.tabs = @[@"3333", @"77355", @"12", @"35677772"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
