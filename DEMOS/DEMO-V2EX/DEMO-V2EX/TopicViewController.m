//
//  TopicViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicTableCell.h"
#import "TopicDetailViewController.h"
#import "DEMO_V2EX-swift.h"

@interface TopicViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSArray<__kindof TopicModel *> *models;
@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableCell" bundle:nil] forCellReuseIdentifier:@"TopicTableCell"];
    
    __weak __typeof(self) weakSelf = self;
    [NetworkManager GET:@"http://www.v2ex.com/api/topics/latest.json" parameter:@{} success:^(NSData * data) {
        NSArray *dicts = data.jsonObject;
        NSMutableArray<__kindof TopicModel *> *models =  [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < dicts.count; index++) {
            NSDictionary *dict = dicts[index];
            TopicModel *model = [[TopicModel alloc] initWithDict:dict];
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

- (void)setModels:(NSArray<__kindof TopicModel *> *)models {
    _models = models;
    
     __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count > 0 ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicTableCell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicDetailViewController * vc = [[TopicDetailViewController alloc] initWithNibName:@"TopicDetailViewController" bundle:nil];
    TopicModel *model = self.models[indexPath.row];
    vc.topicID = model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
