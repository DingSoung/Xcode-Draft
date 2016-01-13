//
//  TestWebViewController.m
//  DEMO
//
//  Created by D.Alex on 12/3/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "TestWebViewController.h"
#import "WebView.h"

@interface TestWebViewController ()

@end

@implementation TestWebViewController {
     WebView *_web;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _web = [[WebView alloc] init];
    [_web setScalesPageToFit:YES];
    [self.view addSubview:_web];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSURL *URL = [[NSURL alloc] initWithString:@"https://www.jasondavies.com/wordcloud/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL];
    [_web loadRequest:request];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _web.frame = self.view.frame;
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
