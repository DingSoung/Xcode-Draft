//
//  TestXibViewController.m
//  testOC
//
//  Created by D.Alex on 11/20/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestXibViewController.h"
#import "PieChartView.h"

@interface TestXibViewController () {
    __weak IBOutlet PieChartView *_pieChartView;
}

@end

@implementation TestXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pieChartView.pieArray = @[@2, @3, @4];
    _pieChartView.pieArray = @[@2, @3, @4, @1, @7, @5];
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
