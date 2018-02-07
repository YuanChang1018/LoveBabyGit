//
//  SearchWebViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/24.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "SearchWebViewController.h"

@interface SearchWebViewController ()

@end

@implementation SearchWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //親子館購物平台 Web IP
    NSURL *url = [NSURL URLWithString:@"http://163.13.128.77:8080"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.WebView loadRequest:request];
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
