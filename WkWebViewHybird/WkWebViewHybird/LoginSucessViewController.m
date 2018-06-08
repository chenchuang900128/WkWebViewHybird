//
//  LoginSucessViewController.m
//  WkWebViewHybird
//
//  Created by chc on 2018/6/8.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "LoginSucessViewController.h"
#import "HybirdWebViewController.h"

@interface LoginSucessViewController ()
- (IBAction)skipHybirdClick:(id)sender;

@end

@implementation LoginSucessViewController

- (IBAction)exitlogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    
}

// 跳转到跨平台html
-(void)skipHybirdClick:(id)sender{
    
    HybirdWebViewController *webVC = [[HybirdWebViewController alloc] init];
    webVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:webVC animated:YES completion:^{

    }];

   
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
