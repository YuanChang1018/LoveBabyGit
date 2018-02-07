//
//  MemberViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UserMemory = [NSUserDefaults standardUserDefaults];
    
    //監聽LoginViewController的廣播 登入成功 run "reload" Funtion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"reload" object:nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1];
    self.navigationItem.title = @"親子館";
    
    //ImageView
    self.MemberImageView.image = [UIImage imageNamed:@"test"];
    
    //ImageView變圓形
    self.MemberImageView.layer.cornerRadius = self.MemberImageView.frame.size.height/2;
    self.MemberImageView.layer.masksToBounds = YES;
    self.MemberImageView.layer.borderWidth = 0;

    
    
    //NameLabel 假資料
    self.MemberNameLabel.text = @"張揚法";
    
    //EmailLabel 假資料
    self.EmailLabel.text = @"seae2145@yahoo.com.tw";
    

}



//"reload" Funtion
-(void)reload:(NSNotification *)notification{
    
    //重整
    [self viewDidLoad];
    
    //回到顯示tabBar第一頁
    [self.tabBarController setSelectedIndex:0];
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

//登出畫面
- (IBAction)LogoutButton:(id)sender {
    
    //帳號紀錄 清空
    [UserMemory setObject:nil forKey:@"Account"];
    
    //切換到storyboard裡名字叫"login"的宣告
    UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    
    //登出動畫
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    //跳出登入畫面
    [self presentViewController:ViewController animated:YES completion:nil];
    
}
@end
