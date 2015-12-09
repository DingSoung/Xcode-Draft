//
//  DSPDFImage.h
//  MCompass
//
//  Created by D.Alex on 11/19/15.
//  Copyright © 2015 haizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSPDFImage : NSObject

+ (id)instance;

-(void) generateImageWithPDF:(NSString *)url size:(CGSize)size pageIndex:(NSUInteger)pageIndex success: (void (^)(UIImage * image))success fail: (void (^)(NSError * error))fail;

@end
