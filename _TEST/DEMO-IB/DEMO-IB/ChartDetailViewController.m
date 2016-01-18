//
//  ChartDetailViewController.m
//  DEMO-IB
//
//  Created by Alex D. on 1/13/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ChartDetailViewController.h"
#import "ChartView.h"

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
    
    
     //_chartView.model = _model.chartModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushChartWithModel:(VCModel *)model {
    if (_models == nil) {
        _models = [NSMutableArray arrayWithArray:@[]];
    }
    if (model != nil ) {
        [_models addObject:model];
    }
    
    [self configChart];
    
    _chartView.model = model.chartModel;
}

- (void)popCharts:(NSInteger)count {
    
    for (NSInteger cnt = count; cnt >= 1; cnt--) {
        if (_models.count >= 1) {
            [_models removeObjectAtIndex:_models.count - 1];
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    
    [self configChart];
}

- (void)configChart {
    if (_models.count >= 1) {
        VCModel *model = _models[_models.count -1];
        _chartView.model = model.chartModel;
    }
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
