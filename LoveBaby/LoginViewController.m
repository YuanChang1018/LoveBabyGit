//
//  LoginViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/7.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LoginViewController.h"
#import "SCLAlertView.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //暗沈背景 隱藏
    self.BackView.hidden = YES;
    
    //轉動UI動畫暫停
    [self.LoginActivity stopAnimating];
    
}

//關閉鍵盤
- (IBAction)BottomBitton:(id)sender {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

//鍵盤裡關閉鍵盤
- (IBAction)sender:(id)sender {
    [sender resignFirstResponder];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //使用者設定 宣告初始化
    UserMemory = [NSUserDefaults standardUserDefaults];
    //使用者設定 紀錄使用者身份
    [UserMemory setObject:@"member" forKey:@"identity"];
    
    //Navigation Bar顏色設定
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1];
    
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
- (IBAction)LoginButton:(id)sender {
    
    //暗沈背景 顯現
    self.BackView.hidden = NO;
    //啟動轉動畫面
    [self.LoginActivity startAnimating];
    
    //關閉鍵盤
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
  

    //當帳號字數少於1
    if (self.AccountText.text.length < 1){
        
        //暗沈背景 隱藏
        self.BackView.hidden = YES;
        
        //轉動UI動畫暫停
        [self.LoginActivity stopAnimating];
        //帳號TextView 搖動
        [self lockAnimationForView:self.AccountText];
        
        
    //當密碼字數少於1
    }else if (self.PasswordText.text.length < 1){
        
        //暗沈背景 隱藏
        self.BackView.hidden = YES;
        //轉動UI動畫暫停
        [self.LoginActivity stopAnimating];
        //密碼TextView 搖動
        [self lockAnimationForView:self.PasswordText];
        
    }else{
        
        //SHA512加密
        //NSString *s = [self sha1];
        
        //NSLog(@"密碼SHA512 : %@",s);
        
        //認證帳號
        [self PostLogin];
        
    }
    

}



//SHA512加密
- (NSString*) sha1
{
    NSString *password = self.PasswordText.text;
    const char *cstr = [password cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:password.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA512(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}




//認證帳號
-(void)PostLogin{
    
    
    
    
    NSLog(@"權限驗證");
    if([UserMemory stringForKey:@"teacher"])
    {
        //認證Server IP
        NSURL *url = [NSURL URLWithString:@"http://163.13.128.77:8080/jy7/LoginInfoCheck.php"];
        //回應Request設定
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:20.0];
        
    //傳遞字串
    NSString *userPeople=@"teacher";
    NSString *value2 = [[NSString alloc]initWithFormat:@"userPeople=%@&loginAccount=%@&loginPassword=%@",userPeople,self.AccountText.text,self.PasswordText.text];
    NSData *postData = [value2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

    
    //POST形式傳送
    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    
    
    //Session 設定
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //Session DataTask下載資料
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data,NSURLResponse *_Nullable response,NSError *_Nullable error){
        
        //下載的訊息
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"html:%@",html);
        
        
        
        //因為執行緒不能改變UI 所以用這個包起來使用UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            //登入認證成功
            if ([html isEqualToString:@"success"]) {
                
                //使用者設定 紀錄帳號
                [UserMemory setObject:self.AccountText.text forKey:@"Account"];
                
                //廣播通知 驗證成功 MainViewController重新整理
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:self userInfo:nil];
                
                
                //換頁 淡出LoginViewController
                CATransition *animation = [CATransition animation];
                animation.duration = 1.0;
                animation.timingFunction = UIViewAnimationCurveEaseInOut;
                animation.type = kCATransitionFade;
                animation.subtype = kCATransitionFromLeft;
                [self.view.window.layer addAnimation:animation forKey:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                NSLog(@"登入成功");
                
                
            
            }
            

            
            
            else//登入認證失敗
            {
                
                ////暗沈背景 隱藏
                self.BackView.hidden = YES;
                [self.LoginActivity stopAnimating];
                
                
                //Alert警告通知
                SCLAlertView *alert = [[SCLAlertView alloc] init];
                [alert addButton:@"註冊" target:self selector:@selector(AlertFirstButton) tag:1];
                alert.shouldDismissOnTapOutside = YES;
                [alert showInfo:self title:@"" subTitle:@"此帳號尚未註冊,是否馬上註冊？" closeButtonTitle:@"取消" duration:0.0f];
                
                
            }

            
            
            
        });
        
        
        
    }];
    
    [dataTask resume];

    }
    else if ([UserMemory stringForKey:@"student"])
    {
        //認證Server IP
        NSURL *url = [NSURL URLWithString:@"http://163.13.128.77:8080/jy7/LoginInfoCheck.php"];
        //回應Request設定
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:20.0];
        //傳遞字串
        NSString *userPeople=@"student";
        NSString *value2 = [[NSString alloc]initWithFormat:@"userPeople=%@&loginAccount=%@&loginPassword=%@",userPeople,self.AccountText.text,self.PasswordText.text];
        NSData *postData = [value2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        
        //POST形式傳送Ω
        request.HTTPMethod = @"POST";
        request.HTTPBody = postData;
        
        
        //Session 設定
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        //Session DataTask下載資料
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data,NSURLResponse *_Nullable response,NSError *_Nullable error){
            
            //下載的訊息
            NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"html:%@",html);
            
            
            
            //因為執行緒不能改變UI 所以用這個包起來使用UI
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                
                //登入認證成功
                if ([html isEqualToString:@"success"]) {
                    
                    //使用者設定 紀錄帳號
                    [UserMemory setObject:self.AccountText.text forKey:@"Account"];
                    
                    //廣播通知 驗證成功 MainViewController重新整理
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:self userInfo:nil];
                    
                    
                    //換頁 淡出LoginViewController
                    CATransition *animation = [CATransition animation];
                    animation.duration = 1.0;
                    animation.timingFunction = UIViewAnimationCurveEaseInOut;
                    animation.type = kCATransitionFade;
                    animation.subtype = kCATransitionFromLeft;
                    [self.view.window.layer addAnimation:animation forKey:nil];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"登入成功");
                    
                    
                    //登入認證失敗
                }
                
                
                
                
                else
                {
                    
                    ////暗沈背景 隱藏
                    self.BackView.hidden = YES;
                    [self.LoginActivity stopAnimating];
                    
                    
                    //Alert警告通知
                    SCLAlertView *alert = [[SCLAlertView alloc] init];
                    [alert addButton:@"註冊" target:self selector:@selector(AlertFirstButton) tag:1];
                    alert.shouldDismissOnTapOutside = YES;
                    [alert showInfo:self title:@"" subTitle:@"此帳號尚未註冊,是否馬上註冊？" closeButtonTitle:@"取消" duration:0.0f];
                    
                    
                }
                
            });
            
        }];
        
        [dataTask resume];
    }
    
    
}


//Segment 身份切換
- (IBAction)IdentitySegment:(id)sender {
    
    switch (self.IdentitySegmentControl.selectedSegmentIndex) {
            
        
        case 0:
            NSLog(@"會員");
            //使用者設定 記錄身份
            [UserMemory setObject:@"student" forKey:@"student"];
            [UserMemory synchronize];
            
            break;
            
            
        case 1:
            NSLog(@"員工");
            //使用者設定 記錄身份
            [UserMemory setObject:@"teacher" forKey:@"teacher"];
            [UserMemory synchronize];
            
            break;
            
            
//        case 2:
//            NSLog(@"行政");
//            //使用者設定 記錄身份
//            [UserMemory setObject:@"basic" forKey:@"identity"];
//
//            break;
//
//
//        case 3:
//            NSLog(@"主任/園長");
//            //使用者設定 記錄身份
//            [UserMemory setObject:@"Supervisor" forKey:@"identity"];
//
//            break;
//
//
//        case 4:
//            NSLog(@"主管機關");
//            //使用者設定 記錄身份
//            [UserMemory setObject:@"society" forKey:@"identity"];
//
//            break;
//
//        case 5:
//            NSLog(@"護理師");
//            //使用者設定 記錄身份
//            [UserMemory setObject:@"society" forKey:@"identity"];
//
//            break;
            
            
        default:
            NSLog(@"管理員");
            //使用者設定 記錄身份
            [UserMemory setObject:@"admin" forKey:@"identity"];
            
            break;
            
            
    }
    
}



//Alert通知 第一個按鈕
- (void)AlertFirstButton
{
    
    NSLog(@"First button tapped");
    //跳轉到註冊畫面 RegisterViewController
    UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"register"];
    [self.navigationController pushViewController:ViewController animated:YES];
    
}


@end
