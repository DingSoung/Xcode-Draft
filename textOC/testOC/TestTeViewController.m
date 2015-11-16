//
//  TestTeViewController.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestTeViewController.h"

@interface TestTeViewController ()

@end

@implementation TestTeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tintColor = UIColor.yellowColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
