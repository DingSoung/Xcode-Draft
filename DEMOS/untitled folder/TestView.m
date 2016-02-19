//
//  testView.m
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import "TestView.h"

@implementation TestView


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



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
