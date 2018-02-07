//
//  NewOpinionViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/24.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "NewOpinionViewController.h"

@interface NewOpinionViewController ()

@end

@implementation NewOpinionViewController

- (void)viewDidLayoutSubviews {
    
    [self.TextView setContentOffset:CGPointZero animated:NO];
    self.TextView.scrollEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"發佈" style:UIBarButtonItemStylePlain target:self action:@selector(addNewOpinion:)];
    
    Buttonitem.tintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    
    self.navigationItem.title = @"留言";
    
    self.TextView.layer.cornerRadius = self.TextView.frame.size.height/8;
    self.TextView.layer.masksToBounds = YES;
    self.TextView.layer.borderWidth = 0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//新增留言按鈕
-(IBAction)addNewOpinion:(id)sender{
    
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
