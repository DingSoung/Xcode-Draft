//
//  GISMapWebView.h
//  MCompass
//
//  Created by Alex D. on 3/8/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class WordCloudWebView;

@protocol WordCloudWebViewDelegate <NSObject>
@optional
- (void) wordCloudInitialized:(WordCloudWebView *) wordCloud;
- (void) wordCloud:(WordCloudWebView *)wordCloud renderStartWithChartId:(NSString *)chartId;
- (void) wordCloud:(WordCloudWebView *)wordCloud renderFinishedWithChartId:(NSString *)chartId;
- (void) wordCloud:(WordCloudWebView *)wordCloud didSelectIndex:(NSInteger)index;
@end

@protocol WordCloudWebViewDataSource <NSObject>
@required
- (NSArray *) textArrayForWordCloud:(WordCloudWebView *)wordCoud;
- (NSArray *) weightArrayForWordCloud:(WordCloudWebView *)wordCoud;
- (NSArray *) colorhexArrayForWordCloud:(WordCloudWebView *)wordCoud;
@end

@interface WordCloudWebView : WKWebView
- (instancetype)initWithFrame:(CGRect)frame chartId:(NSString *)chartId;
@property (nonatomic, weak) id <WordCloudWebViewDataSource> dataSource;
@property (nonatomic, weak) id <WordCloudWebViewDelegate> viewDelegate;
- (BOOL)reloadDataForce:(BOOL)force;
- (void)setChartData;
@end


@interface WordCloudWebView (WKNavigationDelegate)
@end
