//
//  TopicDetailHeaderView.m
//
//
//  Created by Alex D. on 2/26/16.
//
//

#import "TopicDetailHeaderView.h"
#import "Bridging-Header.h"

@implementation TopicDetailHeaderView {
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *infoLabel;
    __weak IBOutlet UIImageView *avatarImage;
    __weak IBOutlet UITextView *contentTextView;
}

- (void)setModel:(TopicModel *)model {
    _model = model;
    
    self->titleLabel.text = self.model.title;
    self->infoLabel.text = [NSString stringWithFormat:@" %@ - %@", self.model.last_modified, self.model.memberModel.username];
    [self->avatarImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http:%@",self.model.memberModel.avatar_mini]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //NSLog(@"%@, %@, %@", image, error.domain, imageURL);
    }];
    self->contentTextView.text = self.model.content;
    
    [self->contentTextView sizeToFit];
    [self->contentTextView sizeThatFits:CGSizeMake(self.bounds.size.width, 9999999)];
    
    CGRect contentFrame = self->contentTextView.frame;
    contentFrame.size.height = self->contentTextView.contentSize.height;
    self->contentTextView.frame = contentFrame;
    
    CGRect frame = self.frame;
    frame.size.height = self->contentTextView.frame.origin.y + self->contentTextView.frame.size.height + 5;
    self.frame = frame;
}

@end
