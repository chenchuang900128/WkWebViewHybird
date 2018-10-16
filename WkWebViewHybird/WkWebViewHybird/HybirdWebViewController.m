//
//  HybirdWebViewController.m
//  WkWebViewHybird
//
//  Created by chc on 2018/6/8.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "HybirdWebViewController.h"
#import "FBKVOController.h"
#import <HybirdWKWebView/MBSHybirdWkWebView.h>

@interface HybirdWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *CloseBtn;

@property (nonatomic,strong)UIProgressView *progressView;
@property (nonatomic,strong)FBKVOController *KVOController;
@end

@implementation HybirdWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat statusH =  CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
   // CGFloat navigationBarHeight = 44.f;
    
    MBSHybirdWkWebView *currentWebView = [MBSHybirdWkWebView hybirdWkWebViewWithFrame:CGRectMake(0, statusH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - statusH) andUrlStr:@"http://news.baidu.com"];
    currentWebView.navigationDelegate = self;
    currentWebView.UIDelegate = self;
    //打开左划回退功能
    currentWebView.allowsBackForwardNavigationGestures=YES;
    [self.view addSubview:currentWebView];
    
    
    //  进度条
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.frame = CGRectMake(0, statusH, self.view.frame.size.width, 8);
    // safari 进度条颜色
    self.progressView.progressTintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0];
    self.progressView.trackTintColor = [UIColor whiteColor];
    self.progressView.progress = 0;
    [self.view addSubview:self.progressView];
    
    // FaceBook KVO框架
    self.KVOController = [FBKVOController controllerWithObserver:self];
    
    // observe clock date property
    [self.KVOController observe:currentWebView keyPath:@"estimatedProgress" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        
        [self.progressView setAlpha:1.0f];
        
        BOOL animated = currentWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:currentWebView.estimatedProgress
                              animated:animated];
        
        if (currentWebView.estimatedProgress >= 1.0f) {
            
            [UIView animateWithDuration:0.25f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [self.progressView setAlpha:0.0f];
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0.0f animated:NO];
                             }];
        }
    }];
    
    
    
    
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
