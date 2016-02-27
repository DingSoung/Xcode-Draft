//
//  FunctionViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 16/2/26.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "FunctionViewController.h"
#import "NodeViewController.h"
#import "TopicViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nodeAction:(UIButton *)sender {
    NodeViewController * vc = [[NodeViewController alloc] initWithNibName:@"NodeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)newAction:(id)sender {
    TopicViewController * vc = [[TopicViewController alloc] initWithNibName:@"TopicViewController" bundle:nil];
    vc.topic = @"recent";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)hotAction:(UIButton *)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
