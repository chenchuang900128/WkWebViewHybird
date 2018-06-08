//
//  ViewController.m
//  WkWebViewHybird
//
//  Created by chc on 2018/6/8.
//  Copyright © 2018年 chc. All rights reserved.
//

#import "ViewController.h"
#import "LoginSucessViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)loginBtnClick:(id)sender {
    
    LoginSucessViewController *loginVC = [[LoginSucessViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:^{
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
