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

//- (void)setModel:(TopicModel *)model {
//    if (model != nil) {
//        _model = model;
//        
//        self->titleLabel.text = _model.title;
//        self->infoLabel.text = [NSString stringWithFormat:@" %@ - %@", _model.last_modified, _model.memberModel.username];
//        self->contentTextView.text = _model.content;
//        
//        [self->contentTextView sizeToFit];
//    }
//}

@end
