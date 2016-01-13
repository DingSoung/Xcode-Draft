//
//  ViewController.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ChartDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showChart:(UIButton *)sender {
    
    ChartDetailViewController * vc = [[ChartDetailViewController alloc] initWithNibName:@"ChartDetailViewController" bundle:nil];
    if (vc != nil) {
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:vc animated:true completion:^{}];
    }
}

@end
