//
//  TopicDetailViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailHeaderView.h"
#import "ReplyTableCell.h"
#import "TopicModel.h"
#import "DEMO_V2EX-swift.h"

@interface TopicDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TopicDetailHeaderView *tableHeaderView;  //谨记 strong, 非copy
@property (nonatomic, copy) NSArray<__kindof ReplyModel *> *replyModels;
@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"TopicDetailHeaderView" owner:self options:nil].firstObject;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableView registerNib:[UINib nibWithNibName:@"ReplyTableCell" bundle:nil] forCellReuseIdentifier:@"ReplyTableCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.replyModels = _replyModels;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.title = self.model.nodeDetailModel.name;
    
    // ref http://www.cnblogs.com/ihojin/p/tableHeaderView-resizeheight.html
    self.tableHeaderView.model = self.model;
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:self.tableHeaderView];
    [self.tableView endUpdates];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)setModel:(TopicModel *)model {
    _model = model;
    
    self.tableHeaderView.model = self.model;
    
    if (self.model.uid == nil) {
        return;
    } else {
        __weak __typeof(self) weakSelf = self;
        [NetworkManager GET:[NSString stringWithFormat:@"http://www.v2ex.com/api/replies/show.json?topic_id=%@",self.model.uid] parameter:@{} success:^(NSData * data) {
            NSArray *dicts = data.jsonObject;
            
            NSMutableArray<__kindof ReplyModel *> *models =  [[NSMutableArray alloc] init];
            for (NSInteger index = 0; index < dicts.count; index++) {
                NSDictionary *dict = dicts[index];
                ReplyModel *model = [[ReplyModel alloc] initWithDict:dict];
                [models addObject:model];
            }
            weakSelf.replyModels = models;
        } fail:^(NSError * error) {
            NSLog(@"%@", error.domain);
        }];
    }
}

- (void)setReplyModels:(NSArray<__kindof ReplyModel *> *)replyModels {
    if (_replyModels != replyModels) {
        _replyModels = replyModels;
    }
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.replyModels.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.replyModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReplyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyTableCell" forIndexPath:indexPath];
    cell.model = self.replyModels[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NodeDetailViewController * vc = [[NodeDetailViewController alloc] initWithNibName:@"NodeDetailViewController" bundle:nil];
    //    NodeModel *model = self.models[indexPath.row];
    //    vc.name = model.name;
    //    [self.navigationController pushViewController:vc animated:YES];
}

@end
