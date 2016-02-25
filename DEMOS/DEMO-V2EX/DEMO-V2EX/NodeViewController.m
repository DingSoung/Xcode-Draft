//
//  NodeViewController.m
//  DEMO-V2EX
//
//  Created by CuiCui2 on 16/2/25.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "NodeViewController.h"
#import "NodeTableCell.h"
#import "DEMO_V2EX-swift.h"

@interface NodeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<__kindof NodeModel *> *models;
@end

@implementation NodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"NodeTableCell" bundle:nil] forCellReuseIdentifier:@"NodeTableCell"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak __typeof(self) weakSelf = self;
    [NetworkManager GET:@"http://www.v2ex.com/api/nodes/all.json" parameter:@{} success:^(NSData * data) {
        NSArray *dicts = data.jsonObject;
        NSMutableArray<__kindof NodeModel *> *models =  [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < dicts.count && index < 10; index++) {
            NSDictionary *dict = dicts[index];
            NodeModel *model = [[NodeModel alloc] initWithDict:dict];
            [models addObject:model];
        }
        weakSelf.models = models;
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter
- (void)setModels:(NSArray<__kindof NodeModel *> *)models {
    if (_models != models) {
        _models = models;
        [self.tableView reloadData];
    }
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NodeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NodeTableCell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 跳转
}

@end
