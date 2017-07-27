//
//  ViewController.m
//  DEMO
//
//  Created by Alex D. on 3/12/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "ViewController.h"
#import "DEMO-swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imageArrayFromHtml = @[];
    CGSize size;
    if (imageArrayFromHtml.count >= 3) {
        size = CGSizeMake(193, 128);
    } else if (imageArrayFromHtml.count == 2) {
        size = CGSizeMake(450, 438);
    } else {
        size = CGSizeMake(930, 480);
    }
    
    NSMutableArray *outArray = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < imageArrayFromHtml.count && index < 3; index++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:imageArrayFromHtml[0]];
        [imgView sizeToFit];
        
        UIImage *inImage = imageArrayFromHtml[index];
        UIImage *outImage;
        
        if (imgView.bounds.size.width > size.width && imgView.bounds.size.height > size.height) {
            [self resizeImageWithStream:inImage outImage:outImage width:size.width height:size.height];
        } else {
            [self resizeImageWithStream:inImage outImage:outImage width:192 height:128];
        }
        [outArray addObject:outImage];
    }
}

- (void)resizeImageWithStream:(UIImage *)inImage outImage:(UIImage *)outImage width:(CGFloat)width height:(CGFloat)height {
    //.....code here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
