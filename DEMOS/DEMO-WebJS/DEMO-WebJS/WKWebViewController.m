//
//  WKWebViewController.m
//  DEMO-WebJS
//
//  Created by Alex D. on 3/10/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "WKWebViewController.h"
#import "WordCloudWebView.h"

@interface WKWebViewController () <WordCloudWebViewDataSource, WordCloudWebViewDelegate>
@property (nonatomic, strong) WordCloudWebView *web;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.web = [[WordCloudWebView alloc] init];
    self.web.dataSource = self;
    self.web.viewDelegate = self;
    [self.view addSubview:self.web];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.web.frame = self.view.bounds;
}

- (void) wordCloudInitialized:(WordCloudWebView *) wordCloud {
    [self.web reloadDataForce:YES];
}

- (NSArray *) textArrayForWordCloud:(WordCloudWebView *)wordCoud {
    return @[@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",@"21",];
}
- (NSArray *) weightArrayForWordCloud:(WordCloudWebView *)wordCoud {
    return @[@12,@12,@12,@12,@12,@12,@12,@12,@12,@12,];
}
- (NSArray *) colorhexArrayForWordCloud:(WordCloudWebView *)wordCoud {
    return @[@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",@"#FFDD55",];
}
@end
