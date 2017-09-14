//
//  ViewController.m
//  DEMO
//
//  Created by Alex D. on 3/25/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "ViewController.h"
#import "DEMO-swift.h"

@interface ViewController () <CCTabbarDelegate>
@property (weak, nonatomic) IBOutlet CCTabbar *tabbar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bt1 = [[UIButton alloc] init];
    [bt1 setTitle:@"节点" forState:UIControlStateNormal];
    [bt1 setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    UIButton *bt2 = [[UIButton alloc] init];
    [bt2 setTitle:@"最新" forState:UIControlStateNormal];
    [bt2 setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    self.tabbar.models = @[bt1, bt2];
    self.tabbar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CCTabbarDelegate
- (void)tabbar:(CCTabbar *)tabbar didSelectAtIndex:(NSInteger)index {
    NSLog(@"selected at %ld", (long)index);
}

@end
