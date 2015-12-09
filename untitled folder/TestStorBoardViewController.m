//
//  TestTeViewController.m
//  testOC
//
//  Created by D.Alex on 11/16/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestTeViewController.h"

@interface TestTeViewController () <UITableViewDelegate, UITableViewDataSource> {
    __weak IBOutlet UITableView *table;
}
@end

#pragma mark - viewcontroller life cycle http://blog.csdn.net/jjunjoe/article/details/8730326
@implementation TestTeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->table.delegate = self;
    self->table.dataSource = self;
    
    self->table.tintColor = UIColor.yellowColor;
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(leftBarButtonItem:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - navigation bar button action
- (void)leftBarButtonItem:(id) sender {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellLeft"];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}




@end




