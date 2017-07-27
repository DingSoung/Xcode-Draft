//
//  ViewController.m
//  DEMO-WebJS
//
//  Created by Alex D. on 3/10/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "ViewController.h"
//#import "UIWebViewController.h"
#import "WKWebViewController.h"

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

- (IBAction)wkWebAction:(UIButton *)sender {

    WKWebViewController *vc = [[WKWebViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)uiWebAction:(UIButton *)sender {
    //UIWebViewController *vc = [[UIWebViewController alloc] init];
    //[self.navigationController pushViewController:vc animated:YES];
}

@end
