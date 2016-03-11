//
//  WordCloudWebView.m
//  MCompass
//
//  Created by Alex D. on 3/8/16.
//  Copyright © 2016 ifnil. All rights reserved.
//

#import "WordCloudWebView.h"
#import "DEMO_WebJS-swift.h"


@interface WordCloudWebView() <WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@end

@implementation WordCloudWebView {
    NSArray *_texts;
    NSArray *_weights;
    NSArray *_colors;
    
    NSString *_chartId;
    BOOL _isInitialized;
    BOOL _isRendering;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //注册js方法
        [self.configuration.userContentController addScriptMessageHandler:self name:@"webViewApp"];
        
        //截取请求
        self.navigationDelegate = self;
        
        self.backgroundColor = UIColor.whiteColor;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.minimumZoomScale = 1;
        self.scrollView.maximumZoomScale = 20;
        NSString *path =  [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        if (path != nil) {
            NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            [self loadHTMLString:html baseURL:[NSURL fileURLWithPath:path]];
        }
        _isInitialized = NO;
        _isRendering = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame chartId:(NSString *)chartId {
    self = [self initWithFrame:frame];
    if (self) {
        _chartId = chartId;
    }
    return self;
}

#pragma mark - dataModel setter
- (BOOL)reloadDataForce:(BOOL)force {
    
    NSArray *newTexts = [self.dataSource textArrayForWordCloud:self];
    NSArray *newWeights = [self.dataSource weightArrayForWordCloud:self];
    NSArray *newColors = [self.dataSource colorhexArrayForWordCloud:self];
    BOOL isSameTexts = _texts.count == newTexts.count;
    for (NSInteger index = 0; index < _texts.count && index < newTexts.count; index++) {
        isSameTexts = isSameTexts && [_texts[index] isEqualToString:newTexts[index]];
    }
    BOOL isSameWeights = _weights.count == newWeights.count;
    for (NSInteger index = 0; index < _weights.count && index < newWeights.count; index++) {
        isSameWeights = isSameWeights && [_weights[index] isEqualToString:newWeights[index]];
    }
    BOOL isSameColors = _colors.count == newColors.count;
    for (NSInteger index = 0; index < _colors.count && index < newColors.count; index++) {
        isSameColors = isSameColors && [_colors[index] isEqualToString:newColors[index]];
    }
    
    if (isSameTexts == YES && isSameWeights == YES && isSameColors == YES && force == NO) {
        return NO;
    } else {
        _texts = newTexts;
        _weights = newWeights;
        _colors = newColors;
        [self setChartData];
        return YES;
    }
}

- (void)reactForWeb:(NSDictionary *)dict {
    NSString *dataStr = [dict objectForKey:@"data"];
    if (dataStr == nil) {
        return;
    }
    NSDictionary *dataDict = dataStr.jsonDict;
    if (dataDict == nil) {
        return;
    }
    NSString *action = [dataDict objectForKey:@"action"];
    id params = [dataDict objectForKey:@"params"];
    
    if (action != nil && params != nil) {
        if ([action isEqualToString:@"initialized"]) {
            _isInitialized = YES;
            [self.viewDelegate wordCloudInitialized:self];
        }
        else if ([action isEqualToString:@"startRender"]) {
            _isRendering = YES;
            [self.viewDelegate wordCloud:self renderStartWithChartId:_chartId];
        }
        else if ([action isEqualToString:@"rendered"]) {
            _isRendering = NO;
            [self.viewDelegate wordCloud:self renderFinishedWithChartId:_chartId];
        }
        else if ([action isEqualToString:@"selectChartItems"]) {
            NSArray *items = [params objectForKey:@"items"];
            if (items.count >= 1) {
                NSDictionary *item = items[0];
                NSString *text = [item objectForKey:@"text"];
                for (NSInteger index = 0; index < _texts.count; index++) {
                    if ([text isEqualToString: _texts[index]]) {
                        [self.viewDelegate wordCloud:self didSelectIndex:index];
                        break;
                    }
                }
            }
        } else {
        }
    }
}

- (void)setChartData {
    NSString *callBack = @"setChartData";
    NSMutableArray *wordClouData = [NSMutableArray arrayWithArray:@[]];
    NSMutableArray *wordClouColor = [NSMutableArray arrayWithArray:@[]];
    for (NSInteger index = 0; index < _texts.count && index < _weights.count; index++) {
        [wordClouData addObject:@{@"text": _texts[index],
                                  @"value": _weights[index],
                                  }];
    }
    [wordClouColor addObjectsFromArray:_colors];
    NSString *json = @{@"data":wordClouData.copy,
                       @"colors":wordClouColor.copy}.jsonStr;
    if (callBack != nil && json != nil) {
        [self runJsWithParams:@[callBack,json]];
    }
}

- (void) runJsWithParams:(NSArray *)params {
    if (_isInitialized == NO || _isRendering == YES) {
        return;
    }
    _isRendering = YES;
    //[self syncRunJsFunction:@"__BDP_CALL_JS__" parameter:params complete:^(JSValue * value) {}];
}


#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //接受传过来的消息从而决定app调用的方法
    NSDictionary *dict = message.body;
    NSString *method = [dict objectForKey:@"method"];
    NSString *para = [dict objectForKey:@"param1"];
    NSLog(@"%@:%@", method, para);
}

@end

@implementation WordCloudWebView (WKNavigationDelegate)
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"finish load %@", navigation);
    
    [self evaluateJavaScript:@"testFunc()" completionHandler:^(id data, NSError *error) {
        NSLog(@"data:%@  error:%@",data, error.domain);
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([navigationAction.request.URL.scheme isEqualToString:@"bdp"]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *params =[navigationAction.request.URL.query componentsSeparatedByString:@"&"];
        for (NSString *para in params) {
            NSArray *strs = [para componentsSeparatedByString:@"="];
            if (strs.count > 1) {
                NSString *key = strs[0];
                NSString *value = [strs[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                if(key && value) {
                    [dict setObject:value forKey:strs[0]];
                } else {}
            } else {}
        }
        [self reactForWeb:dict];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
@end


