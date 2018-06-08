//
//  HybirdWebViewController.m
//  WkWebViewHybird
//
//  Created by chc on 2018/6/8.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "HybirdWebViewController.h"
#import <HybirdWKWebView/MBSHybirdWkWebView.h>


@interface HybirdWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *CloseBtn;

@end

@implementation HybirdWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat statusH =  CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    
    MBSHybirdWkWebView *currentWebView = [MBSHybirdWkWebView hybirdWkWebViewWithFrame:CGRectMake(0, statusH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - statusH) andUrlStr:@"http://news.baidu.com"];
    currentWebView.navigationDelegate = self;
    currentWebView.UIDelegate = self;
    //打开左划回退功能
    currentWebView.allowsBackForwardNavigationGestures=YES;
    [self.view addSubview:currentWebView];
    
    
    [self.view bringSubviewToFront:self.CloseBtn];
    // Do any additional setup after loading the view from its nib.
}


- (void)webView:(WKWebView*)webView decidePolicyForNavigationAction:(WKNavigationAction*)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    
    // 获取导航请求
    NSString *requestStr = [[[navigationAction.request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    // 此处由你们自己公司开发人员一起去定义标识（以什么为关键词开头）
    if ([requestStr hasPrefix:@"nymbsbank://"])
    {
        // 分割字符串 返回数组
        NSArray *myArr = [requestStr componentsSeparatedByString:@"/"];
        if ([myArr count]) {
            // 获取后半段重要字符串
            NSString *valueStr = [myArr lastObject];
            // 分割字符串 返回数组
            myArr = [valueStr componentsSeparatedByString:@"?"];
            if ([myArr count]) {
                // 获取跳转标志字符串
                NSString *flagStr = (NSString *)[myArr firstObject];
                // 获取参数
                // NSString *paramStr = (NSString *)[myArr lastObject];
                // 跳转到主页
                if ([flagStr isEqualToString:@"back"]) {
                    
                    // 返回
                }
                else if ([flagStr isEqualToString:@"main"]) {
                    
                    // 回到主页
                    
                }
                else if ([flagStr isEqualToString:@"login"]) {
                    
                    // 去登录
                    
                }
                
                
            }
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    
}


// 当开始发送请求时调用
- (void)webView:(WKWebView*)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


// 当请求过程中出现错误时调用
- (void)webView:(WKWebView*)webView didFailNavigation:(WKNavigation*)navigation withError:(NSError *)error {
    NSLog(@"%@= %s",error, __FUNCTION__);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

// 当开始发送请求时出错调用
- (void)webView:(WKWebView*)webView didFailProvisionalNavigation:(WKNavigation*)navigation withError:(NSError *)error {
    NSLog(@"%@= %s",error, __FUNCTION__);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}



// 当网页加载完毕时调用：该方法使用最频繁
- (void)webView:(WKWebView*)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

- (IBAction)CloseBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
