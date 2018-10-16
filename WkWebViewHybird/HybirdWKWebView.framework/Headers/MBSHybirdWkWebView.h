//
//  HybirdWkWebView.h
//  WkWebViewHybird
//
//  Created by chc on 2018/6/8.
//  Copyright © 2018年 chc. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface MBSHybirdWkWebView : WKWebView


#pragma mark 跨平台框架
+ (instancetype)hybirdWkWebViewWithFrame:(CGRect)frame andUrlStr:(NSString *)urlStr;

@end
