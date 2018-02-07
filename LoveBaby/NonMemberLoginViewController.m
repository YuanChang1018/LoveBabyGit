//
//  NonMemberLoginViewController.m
//  LoveBaby
//
//  Created by 呂 原彰 on 2018/2/7.
//  Copyright © 2018年 seae2145. All rights reserved.
//

#import "NonMemberLoginViewController.h"

@interface NonMemberLoginViewController ()

@end

@implementation NonMemberLoginViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //暗沈背景 隱藏
    self.nonMemberBackview.hidden = YES;
    
    //轉動UI動畫暫停
    [self.nonMemberActivity stopAnimating];
    
}

- (IBAction)nonBottomBitton:(id)sender {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Navigation Bar Title文字設定
    self.navigationItem.title = @"親子館";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//搖動TextField
-(void)lockAnimationForView:(UIView*)view
{
    //搖動動畫設定
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    //搖動間隔秒
    [animation setDuration:0.08];
    //搖動次數
    [animation setRepeatCount:3];
    [lbl addAnimation:animation forKey:nil];
}


//登入按鈕動作
- (IBAction)nonMemberloginbt:(id)sender {
    
    //暗沈背景 顯現
    self.nonMemberBackview.hidden = NO;
    //啟動轉動畫面
    [self.nonMemberActivity startAnimating];
    
    //關閉鍵盤
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
    
    
    //當帳號字數少於1
    if (self.nonMemberAccount.text.length < 1){
        
        //暗沈背景 隱藏
        self.nonMemberBackview.hidden = YES;
        
        //轉動UI動畫暫停
        [self.nonMemberActivity stopAnimating];
        //帳號TextView 搖動
        [self lockAnimationForView:self.nonMemberAccount];
        
        
        //當密碼字數少於1
    }else if (self.nonMemberEmail.text.length < 1){
        
        //暗沈背景 隱藏
        self.nonMemberBackview.hidden = YES;
        //轉動UI動畫暫停
        [self.nonMemberActivity stopAnimating];
        //密碼TextView 搖動
        [self lockAnimationForView:self.nonMemberEmail];
        
    }else{
        
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"登入成功");
    }
}


@end
