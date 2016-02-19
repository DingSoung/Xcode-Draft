//
//  DetailTableViewCell.m
//  DEMO-IB
//
//  Created by Alex D. on 1/19/16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell {
    
    __weak IBOutlet UILabel *_title;
    __weak IBOutlet UILabel *_detail;
    __weak IBOutlet UILabel *_tag;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DetailModel *)model {
    self->_title.text = model.title;
    // Configure others
}

- (IBAction)operation:(UIButton *)sender {
    
}

@end
