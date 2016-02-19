//
//  ViewController.m
//  testOC
//
//  Created by 丁松 on 15/3/10.
//  Copyright (c) 2015年 丁松. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "TestModel.h"
#import "Singletons.h"
#import "TestSpringView.h"
#import "TestWebViewController.h"
#if 0
#import "UICKeyChainStore.h"
#endif
#import "TestStorBoardViewController.h"
#import "TestXibViewController.h"

#import "DEMO-swift.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *section;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *teststring = @"中文A";
    
    teststring = [teststring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%u", teststring.length);
    NSLog(@"%u", teststring.lenghtOfZhEn);
    
    // Do any additional setup after loading the view, typically from a nib.
    /*
    WrodCloudView *wordle = [[WrodCloudView alloc] initWithFrame:CGRectMake(20, 20 , self.view.frame.size.width - 40, 200) WrodCloudModels:@[]];
    [self.view addSubview:wordle];
    */
    
    TestView * testView = [[TestView alloc] init];
    CGRect frame = testView.frame;  //真烂啊  swift里面一行搞定  在这里要三行
    frame.size = CGSizeMake(self.view.frame.size.width * 0.5, 20);
    frame.origin = CGPointMake(0, 10);
    testView.frame = frame;
    //testView.center = self.view.center;   //每次都要打分号  晕
    [self.view addSubview:testView];
    [TestView testFunction1];
    NSLog(@"func2 %@",[TestView testFunction2:@"ubduysfub"]);
    NSLog(@"func3 %@", [TestView testFunction3:@"shshshshs" times:3]);
    NSLog(@"%ld", testView.times);
    NSLog(@"%d", testView.isFirstTime);
    NSLog(@"%@", testView.str);
    NSLog(@"func 4 %@", [testView testFunc4:@"hahahahaha" times:4]);
    NSLog(@"%ld", testView.times);
    
    TestView * xibView = [[NSBundle mainBundle] loadNibNamed:@"TestView" owner:self options:nil].firstObject;
    if (xibView) {
        xibView.frame = CGRectMake(0, testView.frame.origin.y + testView.frame.size.height, self.view.frame.size.width * 0.5, 100);
        [self.view addSubview:xibView];
    }
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, xibView.frame.origin.y + xibView.frame.size.height + 10, 40, 30)];
    button.backgroundColor = UIColor.greenColor;
    [button addTarget:self action: @selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width + 10, xibView.frame.origin.y + xibView.frame.size.height + 10, 40, 30)];
    button2.backgroundColor = UIColor.greenColor;
    [button2 addTarget:self action: @selector(testButtonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(button2.frame.origin.x + button2.frame.size.width + 10, xibView.frame.origin.y + xibView.frame.size.height + 10, 40, 30)];
    button3.backgroundColor = UIColor.greenColor;
    [button3 addTarget:self action: @selector(testButtonAction3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    UIButton * button4 = [[UIButton alloc] initWithFrame:CGRectMake(button3.frame.origin.x + button3.frame.size.width + 10, xibView.frame.origin.y + xibView.frame.size.height + 10, 40, 30)];
    button4.backgroundColor = UIColor.greenColor;
    [button4 addTarget:self action: @selector(testButtonAction4:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    UIButton * button5 = [[UIButton alloc] initWithFrame:CGRectMake(button4.frame.origin.x + button4.frame.size.width + 10, xibView.frame.origin.y + xibView.frame.size.height + 10, 40, 30)];
    button5.backgroundColor = UIColor.greenColor;
    [button5 addTarget:self action: @selector(testButtonAction5:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    
    
    TestSpringView * percent = [[TestSpringView alloc] init:CGRectMake(0, button.frame.origin.y + button.frame.size.height, 50, 100) backColor:UIColor.grayColor frontColor:UIColor.yellowColor percent:10];
    [self.view addSubview:percent];
    percent.percent = 50;
/*
    NSArray *array = @[@1, @2, @3, @4, @5, @6];
    PieChartView *chart = [[PieChartView alloc] init:CGRectMake(0, percent.frame.origin.y + percent.frame.size.height, 200, 180) sizeArray:array];
    [self.view addSubview:chart];
 */
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[[Singletons alloc] init];  //能初始化 但不能访问内部函数
    [[Singletons instance] func1:@"fefeefe" times:@"hhhhhhh"];
    [[Singletons instance] func2:@"www.baidu.com" parameter:@{@"key": @{@"subKey":@"subValue"}} success:^(id data) {
        //....
    } fail:^(NSError *error) {
        NSLog(@"%@", error.domain);
    }];
    
#if 0
    UICKeyChainStore *keychain = [UICKeyChainStore keyChainStoreWithServer:[NSURL URLWithString:@"https://github.com"]
                                                              protocolType:UICKeyChainStoreProtocolTypeHTTPS
                                                        authenticationType:UICKeyChainStoreAuthenticationTypeHTMLForm];
#if 0
    keychain[@"kishikawakatsumi"] = @"01234567-89ab-cdef-0123-456789abcdef";
    NSString *token = [keychain stringForKey:@"kishikawakatsumi"];
    NSLog(@"token = %@",token);
    keychain[@"kishikawakatsumi"] = nil;
    token = [keychain stringForKey:@"kishikawakatsumi"];
    NSLog(@"token = %@",token);
#else
    NSError *error;
    [keychain setString:@"01234567-89ab-cdef-0123-456789abcdef" forKey:@"kishikawakatsumi" error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    NSString *token = [keychain stringForKey:@"" error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
    NSLog(@"%@",token);
    
    [keychain removeItemForKey:@"kishikawakatsumi" error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }
#endif
#endif
    
    [GCDManager delay:1 block:^{
        NSLog(@"");
    }];
    
    
    NSString *url = @"http://dingsoung.tk/TestCode/httpclient-1.3/demo.php";
    NSDictionary *parameter = @{
                                @"version" : @"0.0.1",
                                @"client" : @"iOS",
                                @"data" : @{
                                        @"operateType" : @"select",
                                        @"operateArea" : @"member"
                                        }
                                };
    [NetworkManager POST:url parameter:parameter success:^(NSData * data) {
        NSDictionary* jsonDict = data.jsonDict;
        if (jsonDict != nil) {
            NSLog(@"%@", jsonDict);
        }
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
    
    
    [[TestCircularReferences alloc] init];
    
    
    dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_queue_t myQueue = dispatch_queue_create("tk.dingsoung.queue", nil);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) testButtonAction:(UIButton *) sender {
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Test" bundle:nil];
    TestStorBoardViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TestStorBoardViewController"];
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:true completion:^{
    }];
}

- (void) testButtonAction2:(UIButton *) sender {
    
    //http://blog.csdn.net/devday/article/details/6736458
    TestXibViewController * vc = [[TestXibViewController alloc] initWithNibName:@"Test" bundle:nil];
    
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:true completion:^{
    }];
}

- (void) testButtonAction3:(UIButton *) sender {
    TestWebViewController *vc = [[TestWebViewController alloc] init];
    UINavigationController * navi = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navi animated:true completion:^{
    }];
}

- (void) testButtonAction4:(UIButton *) sender {
    
    NSString *path =  [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    if (path != nil) {
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
        web.delegate = self;
        [self.view addSubview:web];
        
        [web addJsTarget:@"nativeFunction" block:^(id data) {
            sleep(1);
            NSLog(@"nativeFunction--> %@",data);
        }];
        
        [web loadHTMLString:html baseURL:[NSURL fileURLWithPath:path]];
        
        NSString *json = @"{key:value}";
        [web runJsFunction:@"nativeCallBack" parameter:@[json]];
    }
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
    if (path2 != nil) {
        NSString *js = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
        id result2 = [[JavaScriptManager instance] runJS:js function:@"factorial" parameter:@[@10]];
        NSLog(@"%@",result2);
    }
}

- (void) testButtonAction5:(UIButton *) sender {
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:web];
    
    NSURL *websiteUrl = [NSURL URLWithString:@"https://toxicfork.github.io/react-three-renderer-example/"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [web loadRequest:urlRequest];
}


#pragma mark - UIWebViewDelegate
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"nativefunction"]) {
        NSDictionary *dict = url.query.urlToDict;
        NSLog(@"tempDic:%@",dict);
        return NO;
    }
    return YES;
}


@end


