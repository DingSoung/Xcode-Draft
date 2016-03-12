//
//  TestXib.h
//  testOC
//
//  Created by Alex D. on 11/15/15.
//  Copyright © 2015 丁松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestView : UIView

@property (weak, nonatomic) IBOutlet UILabel *testText;

@property (nonatomic, assign) NSInteger times;
@property (nonatomic, assign) BOOL isFirstTime;

@property (nonatomic, copy) NSString * str;



+(void) testFunction1 ;
+(NSString *) testFunction2: (NSString *)inputStr ;
+(NSString *) testFunction3: (NSString *)inputStr times:(NSInteger) times;


-(NSString *) testFunc4: (NSString *) inputStr times:(NSInteger) times;

@end
