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
#import "NodeDetailViewController.h"

@interface NodeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<__kindof NodeModel *> *models;
@end

@implementation NodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"NodeTableCell" bundle:nil] forCellReuseIdentifier:@"NodeTableCell"];
    
    __weak __typeof(self) weakSelf = self;
    [NetworkManager GET:@"http://www.v2ex.com/api/nodes/all.json" parameter:@{} success:^(NSData * data) {
        NSArray *dicts = data.jsonObject;
        NSMutableArray<__kindof NodeModel *> *models =  [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < dicts.count; index++) {
            NSDictionary *dict = dicts[index];
            NodeModel *model = [[NodeModel alloc] initWithDict:dict];
            [models addObject:model];
        }
        weakSelf.models = models;
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.models = _models;
}

- (void)setModels:(NSArray<__kindof NodeModel *> *)models {
    _models = models;
    
    __weak __typeof(self) weakSelf = self;
    // should reload at main queue,
    // ref http://stackoverflow.com/questions/25958282/uitableview-reloaddata-does-not-refresh-displayed-cells
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NodeDetailViewController * vc = [[NodeDetailViewController alloc] initWithNibName:@"NodeDetailViewController" bundle:nil];
    NodeModel *model = self.models[indexPath.row];
    vc.name = model.name;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
