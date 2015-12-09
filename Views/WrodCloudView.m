//
//  WordleView.m
//  DEMO
//
//  Created by D.Alex on 12/3/15.
//  Copyright © 2015 Alex. All rights reserved.
//

#import "WrodCloudView.h"
#import "CoreText/CoreText.h"

@implementation WrodCloudView

- (instancetype)initWithFrame:(CGRect)frame WrodCloudModels:(NSArray *)models {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *textArray = @[@"Hello",
                               @"World",
                               @"iOS",
                               @"UIKit",
                               @"Cocoa",
                               @"Swif",
                               @"CoreText"];
        NSArray *testColor = @[
                               [UIColor yellowColor],
                               [UIColor blueColor],
                               [UIColor grayColor],
                               [UIColor orangeColor],
                               [UIColor purpleColor],
                               [UIColor whiteColor],
                               [UIColor brownColor],];
        NSMutableArray *testModels = [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < textArray.count && index < testColor.count; index++) {
            NSString *text = [textArray objectAtIndex:index];
            UIColor *color = [testColor objectAtIndex:index];
            WrodCloudModel *model = [[WrodCloudModel alloc] initWithText:text color:color wegiht:index];
            [testModels addObject:model];
        }
        
        _models = testModels;
    }
    return self;
}


//http://www.saitjr.com/ios/use-coretext-make-typesetting-picture-and-text.html
//http://www.cnblogs.com/zanglitao/p/4035655.html
/**
 * 从 View 的中心为起始坐标
 * 该坐标两个垂直方向空白空间的距离需要同时大于Label 的宽高,满足则取空白空间的中心位置放置 Label.
 * 如果不满足,旋转坐标一定的角度,再次判断前面的条件,直到累计角度大于等于180度
 * 以 Label 的最小边距为单位,平移,再次循环上面的步骤,如果不满足,则以单位长度,按弧度移动,如果移动的弧度大于等于360度,则再次平移,再次循环前面的步骤
 * 如果循环360度都超出布局范围,终止所有循环
 */

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


//check if space is enough for current text with special size, angle etc.
- (BOOL)checkSpece {
    //....
    return YES;
}

//draw the text at target point
- (BOOL)asyncDrawWrod {
    //....
    return YES;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if ((_models.count > 0) != YES) {
        return;
    }
    
    for (NSInteger index = 0; index < _models.count; index++) {
        WrodCloudModel *model = [_models objectAtIndex:index];
        if (model == nil) {
            continue;
        }
        
        //prepare word....
        
        CGFloat unitLenght = 20; //<-- min lenght of word
        BOOL drawed = NO;
        
        //radius < view size * 0.5
        for (NSInteger latitude = 0; drawed == NO && latitude * unitLenght < 0.5 * MIN(self.frame.size.width, self.frame.size.height); latitude++) {
            
            //2 * M_PI * radius = perimeter
            //radian = unitLenght/radius = unitLenght / (latitude * unitLenght) = 1/latitude
            for (CGFloat radian = 0.0; drawed == NO && radian <= 2 * M_PI; radian = radian + 1 / latitude) {
                
                // preset 45
                for (CGFloat angle = 0.0; drawed == NO && angle <= M_PI; angle = angle + 0.25 * M_PI) {
                    
                    if ([self checkSpece]) {
                        drawed = YES;
                        [self asyncDrawWrod];
                    }
                }
            }
        }
    }
    
    
    
    //坐标按原点旋转，通过将原点平移到屏幕中心可以实现图片绕中心旋转
    // 因为Core Text要配合Core Graphic 配合使用的，如Core Graphic一样，绘图的时候需要获得当前的上下文进行绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *textArray = @[@"Hello",
                           @"World",
                           @"iOS",
                           @"UIKit",
                           @"Cocoa",
                           @"Swif",
                           @"CoreText"];
    NSArray *testColor = @[
                           [UIColor yellowColor],
                           [UIColor blueColor],
                           [UIColor grayColor],
                           [UIColor orangeColor],
                           [UIColor purpleColor],
                           [UIColor whiteColor],
                           [UIColor brownColor],];
    NSArray *testPoint = @[
                           @{@"x" : @0, @"y": @0},
                           @{@"x" : @40, @"y": @60},
                           @{@"x" : @60, @"y": @-40},
                           @{@"x" : @80, @"y": @20},
                           @{@"x" : @-60, @"y": @-40},
                           @{@"x" : @40, @"y": @-10},
                           @{@"x" : @-20, @"y": @-20},];
    NSArray *testSize = @[
                          @80,
                          @50,
                          @40,
                          @35,
                          @32,
                          @28,
                          @20,];
    NSArray *testAngle = @[
                           @0,
                           @-20,
                           @45,
                           @90,
                           @-60,
                           @-30,
                           @30,];
    
    
    // 移动坐标原点 默认坐标原点在屏幕左下角
    CGContextTranslateCTM(context, 0, rect.size.height);
    // 缩放比例  默认沿y轴正方向是向上的
    CGContextScaleCTM(context, 1, -1);
    // 旋转 相对于原点(0, 0) CGContextRotateCTM(context, 5 * M_PI / 180);
    
    for (NSInteger index = 0; index < textArray.count; index++) {
        NSMutableAttributedString *text =  [[NSMutableAttributedString alloc] initWithString:[textArray objectAtIndex:index]];
        
        //[text addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0, text.length)];
        
        
        // 文字旋转
        CGContextSetTextMatrix(context, CGAffineTransformMakeRotation(0 * M_PI / 180.0)); //CGAffineTransformIdentity
        // 文字颜色
        UIColor *color = [testColor objectAtIndex:index];
        [text addAttribute:(id)kCTForegroundColorAttributeName value: color  range:NSMakeRange(0, text.length)];
        // 文字字体字号
        NSNumber *size = [testSize objectAtIndex:index];
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"Courier", size.doubleValue, NULL);
        [text addAttribute:(id)kCTFontAttributeName value:(__bridge id)fontRef range:NSMakeRange(0, text.length)];
        CFRelease(fontRef);
        // 设置间距
        /*
         CGFloat lineSpacing = 0;
         CTParagraphStyleSetting theSettings[3] = {
         {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
         {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing},
         {kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing}
         };
         CTParagraphStyleRef paragraphRef = CTParagraphStyleCreate(theSettings, 3);
         [text addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)paragraphRef range:NSMakeRange(0, text.length)];
         CFRelease(paragraphRef);*/
        
        // 备份
        CGContextSaveGState(context);
        {
            // 配置坐标
            CGSize suggestedSize = [text boundingRectWithSize:CGSizeMake(rect.size.width, 99999999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
            NSDictionary *dict = [testPoint objectAtIndex:index];
            NSNumber *x = [dict objectForKey:@"x"];
            NSNumber *y = [dict objectForKey:@"y"];
            CGContextTranslateCTM(context,
                                  rect.size.width * 0.5 - suggestedSize.width * 0.5 + x.doubleValue,
                                  -1 * (rect.size.height * 0.5 - suggestedSize.height * 0.5) + y.doubleValue);
            
            // 配置旋转角度
            NSNumber *angle = [testAngle objectAtIndex:index];
            CGContextRotateCTM(context, angle.doubleValue * M_PI / 180);
            
            // 绘制通道 用于画text的区域
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathAddRect(path, NULL, rect); //足够大的区域
            
            //根据AttributedString生成CTFramesetterRef
            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
            CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, text.length), path, NULL);
            CFRelease(path);
            CFRelease(framesetter);
            
            // 进行绘制
            CTFrameDraw(frame, context);
            CFRelease(frame);
        }
        // 还原
        CGContextRestoreGState(context);
    }
    
#if false
    UIImage *image = [UIImage imageNamed:@"picture@2x.jpg"];
    [image drawInRect:rect];
#endif
    
#if false
    NSString *str = [textArray objectAtIndex:0];
    //删除线颜色 CGContextSetRGBStrokeColor(context, 127/255.0, 0/255.0, 250/255.0, 1);
    //填充色
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    //阴影色 CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 5, [UIColor orangeColor].CGColor);
    
    // 填充模式绘制文字
    CGContextSetTextDrawingMode(context,kCGTextFill);
    [str drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:40], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 描边模式绘制文字
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    [str drawAtPoint:CGPointMake(0, 40) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:40], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 描边 填充
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
    [str drawInRect:CGRectMake(0, 80, rect.size.width, rect.size.height - 80) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:40], NSForegroundColorAttributeName:[UIColor whiteColor]}];
#endif
    
#if false
    CGFloat widthConstraint = 500; // Your width constraint, using 500 as an example
    CGSize suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
                                                                        framesetter, /* Framesetter */
                                                                        CFRangeMake(0, text.length), /* String range (entire string) */
                                                                        NULL, /* Frame attributes */
                                                                        CGSizeMake(widthConstraint, CGFLOAT_MAX), /* Constraints (CGFLOAT_MAX indicates unconstrained) */
                                                                        NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */
                                                                        );
    CGFloat width = rect.size.width;
    CGSize suggestedSize = [text boundingRectWithSize:CGSizeMake(width, 99999999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
#endif
    
#if false
    // 步骤10：绘制图片
    UIImage *image = [UIImage imageNamed:@"picture"];
    CGContextDrawImage(context, [self calculateImagePositionInCTFrame:frame], image.CGImage);
#endif
    
#if false
    // 步骤9：图文混排部分
    // CTRunDelegateCallbacks：一个用于保存指针的结构体，由CTRun delegate进行回调
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    // 图片信息字典
    NSDictionary *imgInfoDic = @{@"width":@100,@"height":@30};
    // 设置CTRun的代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)imgInfoDic);
    // 使用0xFFFC作为空白的占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    // 将创建的空白AttributedString插入进当前的attrString中，位置可以随便指定，不能越界
    [attrString insertAttributedString:space atIndex:50];
#endif
}

#if false
#pragma mark - CTRun delegate 回调方法

static CGFloat ascentCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref) {
    return 0;
}

static CGFloat widthCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}
#endif

/**
 *  根据CTFrameRef获得绘制图片的区域
 *
 *  @param ctFrame CTFrameRef对象
 *
 *  @return绘制图片的区域
 */
- (CGRect)calculateImagePositionInCTFrame:(CTFrameRef)ctFrame {
    
    // 获得CTLine数组
    NSArray *lines = (NSArray *)CTFrameGetLines(ctFrame);
    NSInteger lineCount = [lines count];
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    // 遍历每个CTLine
    for (NSInteger i = 0 ; i < lineCount; i++) {
        
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runObjArray = (NSArray *)CTLineGetGlyphRuns(line);
        
        // 遍历每个CTLine中的CTRun
        for (id runObj in runObjArray) {
            
            CTRunRef run = (__bridge CTRunRef)runObj;
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            
            NSDictionary *metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(ctFrame);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            return delegateBounds;
        }
    }
    return CGRectZero;
}

@end
