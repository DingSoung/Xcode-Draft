//
//  TopicTableCell.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "TopicTableCell.h"
#import "Bridging-Header.h"

@implementation TopicTableCell {
    __weak IBOutlet UILabel *titleLabel;
    
    __weak IBOutlet UILabel *creatLabel;
    
    __weak IBOutlet UIImageView *avatarImage;
    __weak IBOutlet UILabel *infoLabel;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(TopicModel *)model {
    _model = model;
    
    self->titleLabel.text = self.model.title;
    self->creatLabel.text = [NSString stringWithFormat:@"%@",self.model.created];
    [self->avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.model.memberModel.avatar_normal]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //NSLog(@"%@, %@, %@", image, error.domain, imageURL);
    }];
    self->infoLabel.text = self.model.memberModel.username;
}

@end
