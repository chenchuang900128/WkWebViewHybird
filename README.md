WkWebViewHybird
   
 基于WKWebView控件上跨平台框架，相对于UIWebView控件跨平台占用内存少，体验好，且完美解决登录Cookies同步共享！
 
 使用方法：
 
 导入动态库HybirdWKWebView.framework， 并在Xcode工程中 Embedded Binaries 和 Linked Frameworks and Libraries配置选项添加该动态库
 
 
 跨平台HybirdWKWebView创建：
 
    CGFloat statusH =  CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    MBSHybirdWkWebView *currentWebView = [MBSHybirdWkWebView hybirdWkWebViewWithFrame:CGRectMake(0, statusH, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - statusH) andUrlStr:@"http://news.baidu.com"];
    currentWebView.navigationDelegate = self;
    currentWebView.UIDelegate = self;
    //打开左划回退功能
    currentWebView.allowsBackForwardNavigationGestures=YES;
    [self.view addSubview:currentWebView];
    
 
 
 wkWebView代理协议方法调用（注意事先控制器UIViewContrller遵守wkWebView代理协议）：
 
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

如有疑问，可以下载Demo工程，进一步了解！
 
 
 
