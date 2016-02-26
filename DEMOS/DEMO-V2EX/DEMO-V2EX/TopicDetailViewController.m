//
//  TopicDetailViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicModel.h"
#import "ReplyModel.h"
#import "DEMO_V2EX-swift.h"

@interface TopicDetailViewController ()
@property (nonatomic, copy) TopicModel *topicModel;
@property (nonatomic, copy) NSArray<__kindof ReplyModel *> *replyModels;
@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //self.model = _model;
}

- (void)setTopicID:(NSString *)topicID {
    __weak __typeof(self) weakSelf = self;
    
    [NetworkManager GET:[NSString stringWithFormat:@"http://www.v2ex.com/api/topics/show.json?id=%@",topicID] parameter:@{} success:^(NSData * data) {
        NSArray *dicts = data.jsonObject;
        for (NSInteger index = 0; index < dicts.count; index++) {
            NSDictionary *dict = dicts[index];
            TopicModel *model = [[TopicModel alloc] initWithDict:dict];
            //
            break;
        }
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
    
    [NetworkManager GET:[NSString stringWithFormat:@"http://www.v2ex.com/api/replies/show.json?topic_id=%@",topicID] parameter:@{} success:^(NSData * data) {
        NSArray *dicts = data.jsonObject;
        
        NSMutableArray<__kindof ReplyModel *> *models =  [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < dicts.count; index++) {
            NSDictionary *dict = dicts[index];
            ReplyModel *model = [[ReplyModel alloc] initWithDict:dict];
            [models addObject:model];
        }
        weakSelf.replyModels = models;
        //dispatch_async(dispatch_get_main_queue(), ^{
        //    [weakSelf.tableView reloadData];
        //});
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
}

@end
