//
//  ReplyTableCell.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "ReplyTableCell.h"

@implementation ReplyTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ReplyModel *)model {
    self.textLabel.text = model.memberModel.username;
    self.detailTextLabel.text = model.content;
}

@end
