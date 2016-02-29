//
//  ReplyTableCell.m
//  DEMO-V2EX
//
//  Created by Alex D. on 2/26/16.
//  Copyright © 2016 Cui. All rights reserved.
//

#import "ReplyTableCell.h"
#import "Bridging-Header.h"

@implementation ReplyTableCell {
    __weak IBOutlet UIImageView *avatarImage;
    __weak IBOutlet UILabel *infoLabel;
    __weak IBOutlet UILabel *detailLabel;
}

- (void)setModel:(ReplyModel *)model {
    _model = model;
    
    [self->avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.model.memberModel.avatar_normal]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //NSLog(@"%@, %@, %@", image, error.domain, imageURL);
    }];
    self->infoLabel.text = self.model.memberModel.username;
    self->detailLabel.text = self.model.content;
}

@end
