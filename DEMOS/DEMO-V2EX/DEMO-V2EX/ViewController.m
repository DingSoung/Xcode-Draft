//
//  ViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/25/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "ViewController.h"
#import "NodeTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)guest:(UIButton *)sender {
    NodeTableViewController * vc = [[NodeTableViewController alloc] initWithNibName:@"NodeTableViewController" bundle:nil];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:true completion:^{
    }];
}

- (IBAction)login:(UIButton *)sender {
}

@end
