//
//  TopicTableCell.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicTableCell.h"

@implementation TopicTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TopicModel *)model {
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.memberModel.username;
}

@end
