//
//  PicEditViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/17.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "PicEditViewController.h"

@interface PicEditViewController ()

@end

@implementation PicEditViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"照片時間";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(PicTimeFinish:)];
    
    Buttonitem.tintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    
    
    
    
}

//增加相片按鈕
-(IBAction)PicTimeFinish:(id)sender{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddPicReload" object:self userInfo:nil];
    
    
    NSString *Date = [NSString stringWithFormat:@"%@",self.PicDatePick.date];
    
    //設定時間
    NSString *str = Date;
    NSString *str2 = [str substringWithRange:NSMakeRange(8, 2)];
    //時間轉換
    int dateint = [str2 intValue] + 1;
    NSString *dateStr = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:[NSString stringWithFormat:@"%d",dateint]];
    
    
    
    //選擇的日期
    [PicMemory setObject:[dateStr substringToIndex:10] forKey:@"PicDate"];
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PicMemory = [NSUserDefaults standardUserDefaults];
    
    //設定時間
    NSString *str = [PicMemory objectForKey:@"PicDate"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormat dateFromString:str];
    [self.PicDatePick setDate:date animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
