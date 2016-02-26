//
//  NodeDetailViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 16/2/26.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "NodeDetailViewController.h"
#import "NodeDetailModel.h"
#import "DEMO_V2EX-swift.h"

@interface NodeDetailViewController ()
@property (nonatomic, copy) NodeDetailModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@end

@implementation NodeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.model = _model;
}

- (void)setName:(NSString *)name {
    __weak __typeof(self) weakSelf = self;
    [NetworkManager GET:[NSString stringWithFormat:@"http://www.v2ex.com/api/nodes/show.json?name=%@",name] parameter:@{} success:^(NSData * data) {
        NSDictionary *dict = data.jsonObject;
        NodeDetailModel *model = [[NodeDetailModel alloc] initWithDict:dict];
        weakSelf.model = model;
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
}

- (void)setModel:(NodeDetailModel *)model {
    _model = model;
    
    self.nameLabel.text = self.model.name;
    self.headerLabel.text = self.model.header;
}

@end
