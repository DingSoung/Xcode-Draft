//
//  TestXib.m
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestXib.h"

@implementation TestXib

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    
    //Just in case the size is different (you may or may not want this)
    mainView.frame = self.bounds;
    
    [self addSubview:mainView];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.testText.font = [UIFont systemFontOfSize:20];
    self.testText.textColor = UIColor.redColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
