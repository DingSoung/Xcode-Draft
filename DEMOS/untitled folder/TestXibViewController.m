//
//  TestXibViewController.m
//  testOC
//
//  Created by D.Alex on 11/20/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestXibViewController.h"
#import "TestXib.h"

@interface TestXibViewController () {
    
    __weak IBOutlet TestXib *topView;
}

@end

@implementation TestXibViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //dont override loadview, will auto load via xib file http://stackoverflow.com/questions/1448207/how-to-load-an-xib
    //replace with custom xib view
    //self->topView = [[[NSBundle mainBundle] loadNibNamed:@"TestXib" owner:self options:nil] objectAtIndex:0];
    
    
    // Do any additional setup after loading the view from its nib.
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
