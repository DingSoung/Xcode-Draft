//
//  DetailView.m
//  DEMO-IB
//
//  Created by Alex D. on 1/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "DetailTableView.h"
#import "DetailTableViewCell.h"
#import "DetailModel.h"

@interface DetailTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailTableView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    self.estimatedRowHeight = 100;
}

- (void)setModels:(NSArray *)models {
    if (_models != models) {
        _models = models;
    }
    [self reloadData];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:self options:nil].firstObject;
    }
    DetailModel *model = self.models[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailModel *model = self.models[indexPath.row];
#ifdef DEBUG
    NSLog(@"%@", model);
#endif
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.domainTableView.bounds), HEADER_HEIGHT)];
    headerBlankView.backgroundColor = [UIColor whiteColor];
    return headerBlankView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerBlankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.domainTableView.bounds), HEADER_HEIGHT)];
    headerBlankView.backgroundColor = [UIColor whiteColor];
    return headerBlankView;
}*/

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ROW_HEIGHT;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

@end
