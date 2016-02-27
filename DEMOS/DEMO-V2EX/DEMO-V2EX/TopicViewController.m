//
//  TopicViewController.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#define USE_HTML_SOURCE 0

#import "TopicViewController.h"
#import "TopicTableCell.h"
#import "TopicDetailViewController.h"
#import "DEMO_V2EX-swift.h"

#if USE_HTML_SOURCE
#import "HTMLParser.h"
#import "HTMLNode.h"
//#import <RegexKitLite.h>
#endif


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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.models = _models;
}

- (void)setTopic:(NSString *)topic {
    self.title = topic;
    
    __weak __typeof(self) weakSelf = self;
#if USE_HTML_SOURCE
    NSString *url = [NSString stringWithFormat:@"http://www.v2ex.com/%@?%@=%@",topic, @"p", @1];
#else
    NSString *url = @"http://www.v2ex.com/api/topics/latest.json";
#endif
    [NetworkManager GET:url parameter:@{} success:^(NSData * data) {
#if USE_HTML_SOURCE
        {
            NSMutableArray *topicArray = [[NSMutableArray alloc] init];
            
            NSString *htmlString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSError *error = nil;
            HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlString error:&error];
            if (error == nil) {
                HTMLNode *bodyNode = [parser body];
                NSArray *cellNodes = [bodyNode findChildTags:@"div"];
                for (HTMLNode *cellNode in cellNodes) {
                    if ([[cellNode getAttributeNamed:@"class"] isEqualToString:@"cell item"]) {
                        
                        TopicModel *model = [[TopicModel alloc] init];
                        model.memberModel = [[MemberModel alloc] init];
                        model.nodeDetailModel = [[NodeDetailModel alloc] init];
                        
                        
                        NSArray *tdNodes = [cellNode findChildTags:@"td"];
                        
                        NSInteger index = 0;
                        for (HTMLNode *tdNode in tdNodes) {
                            NSString *content = tdNode.rawContents;
                            if ([content rangeOfString:@"class=\"avatar\""].location != NSNotFound) {
                                
                                HTMLNode *userIdNode = [tdNode findChildTag:@"a"];
                                if (userIdNode) {
                                    NSString *idUrlString = [userIdNode getAttributeNamed:@"href"];
                                    model.memberModel.username = [[idUrlString componentsSeparatedByString:@"/"] lastObject];
                                }
                                
                                HTMLNode *avatarNode = [tdNode findChildTag:@"img"];
                                if (avatarNode) {
                                    NSString *avatarString = [avatarNode getAttributeNamed:@"src"];
                                    if ([avatarString hasPrefix:@"//"]) {
                                        avatarString = [@"http:" stringByAppendingString:avatarString];
                                    }
                                    model.memberModel.avatar_normal = avatarString;
                                }
                            }
                            if ([content rangeOfString:@"class=\"item_title\""].location != NSNotFound) {
                                
                                NSArray *aNodes = [tdNode findChildTags:@"a"];
                                
                                for (HTMLNode *aNode in aNodes) {
                                    if ([[aNode getAttributeNamed:@"class"] isEqualToString:@"node"]) {
                                        NSString *nodeUrlString = [aNode getAttributeNamed:@"href"];
                                        model.nodeDetailModel.name = [[nodeUrlString componentsSeparatedByString:@"/"] lastObject];
                                        model.nodeDetailModel.title = aNode.allContents;
                                        
                                    } else {
                                        if ([aNode.rawContents rangeOfString:@"reply"].location != NSNotFound) {
                                            model.title = aNode.allContents;
                                            
                                            NSString *topicIdString = [aNode getAttributeNamed:@"href"];
                                            NSArray *subArray = [topicIdString componentsSeparatedByString:@"#"];
                                            model.uid = [(NSString *)subArray.firstObject stringByReplacingOccurrencesOfString:@"/t/" withString:@""];
                                            model.replies = [(NSString *)subArray.lastObject stringByReplacingOccurrencesOfString:@"reply" withString:@""];
                                        }
                                    }
                                }
                                
                                NSArray *spanNodes = [tdNode findChildTags:@"span"];
                                for (HTMLNode *spanNode in spanNodes) {
                                    if ([spanNode.rawContents rangeOfString:@"href"].location == NSNotFound) {
                                        model.created = spanNode.allContents;
                                    }
                                    if ([spanNode.rawContents rangeOfString:@"最后回复"].location != NSNotFound || [spanNode.rawContents rangeOfString:@"前"].location != NSNotFound) {
                                        NSString *contentString = spanNode.allContents;
                                        NSArray *components = [contentString componentsSeparatedByString:@"  •  "];
                                        NSString *dateString;
                                        if (components.count > 2) {
                                            dateString = components[2];
                                        } else {
                                            //dateString = [contentString stringByReplacingOccurrencesOfRegex:@"  •  (.*?)$" withString:@""];
                                        }
                                        NSArray *stringArray = [dateString componentsSeparatedByString:@" "];
                                        if (stringArray.count > 1) {
                                            NSString *unitString = @"";
                                            NSString *subString = [(NSString *)stringArray[1] substringToIndex:1];
                                            if ([subString isEqualToString:@"分"]) {
                                                unitString = @"分钟前";
                                            }
                                            if ([subString isEqualToString:@"小"]) {
                                                unitString = @"小时前";
                                            }
                                            if ([subString isEqualToString:@"天"]) {
                                                unitString = @"天前";
                                            }
                                            dateString = [NSString stringWithFormat:@"%@%@", stringArray[0], unitString];
                                        } else {
                                            dateString = @"刚刚";
                                        }
                                        model.created = dateString;
                                    }
                                }
                                
                            }
                            index ++;
                        }
                        //model.state = [[V2TopicStateManager manager] getTopicStateWithTopicModel:model];
                        //model.cellHeight = [V2TopicListCell heightWithTopicModel:model];
                        [topicArray addObject:model];
                    }
                }
            }
            weakSelf.models = topicArray;
        }
#else
        NSArray *dicts = data.jsonObject;
        NSMutableArray<__kindof TopicModel *> *models =  [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < dicts.count; index++) {
            NSDictionary *dict = dicts[index];
            TopicModel *model = [[TopicModel alloc] initWithDict:dict];
            [models addObject:model];
        }
        weakSelf.models = models;
#endif
    } fail:^(NSError * error) {
        NSLog(@"%@", error.domain);
    }];
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
    vc.model = self.models[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
