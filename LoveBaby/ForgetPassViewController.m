//
//  ForgetPassViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/22.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ForgetPassViewController.h"

@interface ForgetPassViewController ()

@end

@implementation ForgetPassViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"更改密碼";
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)SendButton:(id)sender {
    
    OldPassword = self.OldPassText.text;
    NewPassword = self.NewPassText.text;
    VerificationPassword = self.verificationText.text;
    
    
    
}
@end
