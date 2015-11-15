//
//  TestXib.m
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestXib.h"

@implementation TestXib

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
