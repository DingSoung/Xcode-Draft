//
//  NodeTableCell.m
//  DEMO-V2EX
//
//  Created by CuiCui2 on 16/2/25.
//  Copyright © 2016年 Cui. All rights reserved.
//

#import "NodeTableCell.h"
@implementation NodeTableCell {
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *headerLabel;
}

- (void)setModel:(NodeModel *)model {
    self->nameLabel.text = model.name;
    self->headerLabel.text = model.header;
}

@end
