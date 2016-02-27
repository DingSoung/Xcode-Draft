//
//  TopicDetailHeaderView.m
//
//
//  Created by Alex D. on 2/26/16.
//
//

#import "TopicDetailHeaderView.h"

@implementation TopicDetailHeaderView {
    __weak IBOutlet UILabel *titleLabel;
    __weak IBOutlet UILabel *infoLabel;
    __weak IBOutlet UITextView *contentTextView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    

    
}
- (void)setModel:(TopicModel *)model {
    _model = model;
    
    self->titleLabel.text = _model.title;
    self->infoLabel.text = [NSString stringWithFormat:@" %@ - %@", _model.last_modified, _model.memberModel.username];
    self->contentTextView.text = _model.content;
    
    [self->contentTextView sizeToFit];
    
    [self->contentTextView sizeThatFits:CGSizeMake(self.bounds.size.width, 9999999)];
    
    CGRect contentFrame = self->contentTextView.frame;
    contentFrame.size.height = self->contentTextView.contentSize.height;
    self->contentTextView.frame = contentFrame;
    
    CGRect frame = self.frame;
    frame.size.height = self->contentTextView.frame.origin.y + self->contentTextView.frame.size.height + 5;
    self.frame = frame;
    
//    [self systemLayoutSizeFittingSize:self.bounds.size];
}

@end
