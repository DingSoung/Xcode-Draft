//
//  ChartDetailViewController.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ChartDetailViewController.h"
#import "ChartView.h"
#import "DetailTableView.h"

@implementation VCModel
- (instancetype)init
{
    self = [super init];
    if (self) {
       _chartModel = [[ChartModel alloc] init];
    }
    return self;
}
@end

@interface ChartDetailViewController ()
@end

@implementation ChartDetailViewController {
    NSMutableArray *_models;
    __weak IBOutlet ChartView *_chartView;
    __weak IBOutlet DetailTableView *_detailTableView;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self updateViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushChartWithModel:(VCModel *)model {
    if (_models == nil) {
        _models = [NSMutableArray arrayWithArray:@[]];
    }
    if (model != nil ) {
        [_models addObject:model];
    }
    
    [self updateViewController];
}

- (void)popChartsWithCount:(NSInteger)count {
    
    for (NSInteger cnt = count; cnt >= 1; cnt--) {
        if (_models.count >= 1) {
            [_models removeObjectAtIndex:_models.count - 1];
        }
    }
    
    if (_models.count >= 1) {
        [self updateViewController];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)updateViewController {
    if (_models.count >= 1) {
        VCModel *model = _models[_models.count -1];
        _chartView.model = model.chartModel;
    }
    
    //...
    NSMutableArray *models = [NSMutableArray arrayWithArray:@[]];
    for (NSInteger index = 0; index <= 5; index++) {
        DetailModel *model = [[DetailModel alloc] init];
        model.title = @"test title";
        [models addObject:model];
    }
    _detailTableView.models = models;
}

- (IBAction)popAndClouse:(UIButton *)sender {
    [self popChartsWithCount:1];
}

- (IBAction)filter:(UIButton *)sender {
    // update model here
    if (_models.count % 2 == 0) {
        VCModel *model = [[VCModel alloc] init];
        model.chartModel.chartType = ChartTypePie;
        [self pushChartWithModel:model];
    } else {
        VCModel *model = [[VCModel alloc] init];
        model.chartModel.chartType = ChartTypeWordle;
        [self pushChartWithModel:model];
    }
}




@end
