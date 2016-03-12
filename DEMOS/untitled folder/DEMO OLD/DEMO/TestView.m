//
//  TestXib.m
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
/*
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    UIView *mainView = [subviewArray objectAtIndex:0];
    
    //Just in case the size is different (you may or may not want this)
    mainView.frame = self.bounds;
    
    [self addSubview:mainView];
    
    return self;
}*/

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.testText.font = [UIFont systemFontOfSize:20];
    self.testText.textColor = UIColor.redColor;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * squre = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 30, 40)];
        
        squre.layer.borderWidth = 10;
        squre.layer.borderColor = [UIColor.yellowColor CGColor];
        
        [self addSubview:squre];
    }
    return self;
}


+(void) testFunction1 {
    NSLog(@"func1 called");
}

+(NSString *) testFunction2: (NSString *)inputStr {
    return [inputStr stringByAppendingString:@"test appedt strngfef"];
}

+(NSString *) testFunction3: (NSString *)inputStr times:(NSInteger) times {
    NSString * string = @"";
    for (NSInteger time = 0; time < times; time++) {
        NSString * str = [NSString stringWithFormat:@" %ld", time];
        NSLog(@"%@", str);
        
        string = [string stringByAppendingString: inputStr];
        string = [string stringByAppendingString: str];
    }
    return string;
}


-(NSString *) testFunc4: (NSString *) inputStr times:(NSInteger) times {
    self.times = times;
    self.str = @"";
    
    for (NSInteger time = 0; time < times; time++) {
        NSLog(@"%ld", time);
        NSString * str = [NSString stringWithFormat:@" %ld", time];
        self.str = [self.str stringByAppendingString: str];
    }
    return self.str;
}

@end
