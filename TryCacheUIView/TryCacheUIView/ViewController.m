//
//  ViewController.m
//  TryCacheUIView
//
//  Created by Songwen Ding on 9/5/16.
//  Copyright © 2016 DingSoung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.button = [[UIButton alloc] init];
    self.button.backgroundColor = UIColor.redColor;
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.button.frame = CGRectMake(0, 100, 40, 20);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(UIButton *)sender {
    UIView *v = [UIView new];
    @try {
        UILabel *l = v;
        if (l.text.length > 0) {
            
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = UIColor.whiteColor;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
