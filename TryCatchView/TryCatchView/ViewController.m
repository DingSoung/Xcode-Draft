//
//  ViewController.m
//  TryCatchView
//
//  Created by Songwen Ding on 12/3/16.
//  Copyright © 2016 DingSoung. All rights reserved.
//

#import "ViewController.h"
#import "CustView.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)start:(id)sender {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    dispatch_async(dispatch_queue_create("11111", 0), ^{
        for (int i = 0; i < 10000; i++) {
            
            dispatch_async(dispatch_queue_create("hshshshshhs", 0), ^{
                @try {
                    CustView *v = [[CustView alloc] init];
                    v.frame = CGRectMake(0, 0, 100, 100);
                    [v setNeedsDisplay];
                    //((NSString *)v).length;
                } @catch (NSException *exception) {
                    //printf("%s",exception.reason.UTF8String);
                } @finally {
                }
            });
        }
    });
    
    

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
