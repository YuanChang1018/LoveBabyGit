//
//  MainViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import "MainViewController.h"
#import "OrderViewController.h"
#import "CalendarViewController.h"
#import "EmployeeServiceViewController.h"
#import "OpinionTableViewController.h"
#import "LogViewController.h"
#import "HealthViewController.h"
#import "ImageNotificationViewController.h"
#import "WebNotificationViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Navigation Back返回鍵 圖片取代
    //創建新的BarButton
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;

    
    self.navigationItem.hidesBackButton = YES;
    self.tabBarController.navigationItem.hidesBackButton = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //使用者設定 宣告初始化
    UserMemory = [NSUserDefaults standardUserDefaults];
    //紀錄手機尺寸
    [UserMemory setFloat:self.view.frame.size.width forKey:@"ViewSize"];
    //隱藏PageView (要用在打開)
    self.PageView.hidden = YES;
    

    //會員名稱
    NameArray = [[NSMutableArray alloc] init];
    //假資料 (之後要更改！！)
    [NameArray addObject:@"Henry"];

    
    
    //判斷App是否第一次登入 沒登入過的話跳轉回登入畫面
    if ([UserMemory objectForKey:@"Account"] == nil) {
        
        //創建新View宣告 LoginViewController
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        
        //動畫設定 淡出
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromLeft;
        [self.view.window.layer addAnimation:animation forKey:nil];
        //創建新View
        [self presentViewController:ViewController animated:YES completion:nil];
        
    }
        
    
    //監聽LoginViewController的廣播 登入成功 run "reload" Funtion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"reload" object:nil];
    
    //監聽 圖片推播廣播 收到廣播進入"ImageNotification" Funtion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PicNotification:) name:@"ImageNotification" object:nil];
    
    //監聽 網站推播廣播 收到廣播進入"WebNotification" Funtion
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WebNotification:) name:@"WebNotification" object:nil];
    
    //設定Navigation Bar顏色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1];
    //設定Navigation Bar Title 文字
    self.navigationItem.title = @"親子館";
   

    //PageView 顏色(現可不管)
    self.PageView.currentPageIndicatorTintColor = [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1];
    self.PageView.numberOfPages = 1;
    
    for (int i = 0; i<self.PageView.numberOfPages; i++) {
        
        //整個畫面UI設定 (重要!!!!!)
        [self MemberContent:i];    //i越多畫面數量越多
    }
    
    
    
    
    


}


//廣播 "reload" Funtion
-(void)reload:(NSNotification *)notification{
    
    //重新reload view
    [self viewWillAppear:YES];

}


//廣播 "ImageNotification" Funtion
-(void)PicNotification:(NSNotification *)notification{
    
    //跳轉到ImageNotificationViewController
    ImageNotificationViewController *ViewController = [[ImageNotificationViewController alloc] init];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
}

//廣播 "WebNotification" Funtion
-(void)WebNotification:(NSNotification *)notification{
    
    //跳轉到WebNotificationViewController
    WebNotificationViewController *ViewController = [[WebNotificationViewController alloc] init];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//畫面設定
-(void)MemberContent:(int)Membercount{
    
    //ScrollView 長高 紀錄
    CGFloat scrollWidth = self.ScrollView.bounds.size.width;
    CGFloat scrollHeight = self.ScrollView.bounds.size.height;
    //ContentView長 紀錄
    CGFloat viewWidth = self.ContentView.frame.size.width;
    
    NSLog(@"ContentView.frame width: %f",self.ContentView.frame.size.width);
    NSLog(@"ContentView.frame height: %f",self.ContentView.frame.size.height);
    NSLog(@"scrollWidth : %f",scrollWidth);
    NSLog(@"scrollHeigh : %f",scrollHeight);
    
    //手機是iphone plus 規格的畫面調整
    if(self.view.frame.size.width == 414){
        //ScrollView 裡面內容的長高大小設定
        self.ScrollView.contentSize = CGSizeMake((scrollWidth * self.PageView.numberOfPages + 30)+(30*Membercount), self.ScrollView.bounds.size.height);
    //手機是iphone 7 規格的畫面調整
    }else if (self.view.frame.size.width == 375){
        self.ScrollView.contentSize = CGSizeMake(scrollWidth * self.PageView.numberOfPages, self.ScrollView.bounds.size.height);
    //手機是iphone SE 規格的畫面調整
    }else{
        self.ScrollView.contentSize = CGSizeMake((scrollWidth-50) * self.PageView.numberOfPages - 100, self.ContentView.frame.size.height-20);
        
    }
    
    //ScrollView陰影顏色
    self.ScrollView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //ScrollView陰影的漸變距離,從裡開始往外
    self.ScrollView.layer.shadowRadius = 5;
    
    //ScrollView陰影的大小
    self.ScrollView.layer.shadowOffset = CGSizeMake(5, 5);
    
    //ScrollView陰影透明度
    self.ScrollView.layer.shadowOpacity = 0.5;
    
    
    
    //放在SrollView裡面ContentView的設定
    self.ContentView = [[UIView alloc] init];
    //ContentView圓角數值設定
    self.ContentView.layer.cornerRadius = 20;
    
    //手機是iphone plus 規格的畫面調整
    if (self.view.frame.size.width == 414) {
        //ContentView長高大小設定
        self.ContentView.frame = CGRectMake((scrollWidth*Membercount) +((viewWidth/5-30)*Membercount)+20,0, scrollWidth-10, scrollHeight+40);
    //手機是iphone 7 規格的畫面調整
    }else if (self.view.frame.size.width == 375){
        self.ContentView.frame = CGRectMake((scrollWidth*Membercount),0, scrollWidth-10, scrollHeight-10);
    //手機是iphone SE 規格的畫面調整
    }else{
        self.ContentView.frame = CGRectMake(((scrollWidth-50)*Membercount),0, scrollWidth-70, 500-115);
    }
    
    //ContentView背景顏色
    self.ContentView.backgroundColor = [UIColor whiteColor];
    
    //ContentView裡面第一個ImageView
    self.ImageView = [[UIImageView alloc] init];
    
    //假資料 (會員大頭照圖片！！！)
    self.ImageView.image = [UIImage imageNamed:@"test"];
    
    if (self.view.frame.size.width == 320) {
        //ImageView位置長高大小設定
        self.ImageView.frame = self.ImageView.frame = CGRectMake(10 , 15 , 75 , 75);
    }else{
        //ImageView位置長高大小設定
        self.ImageView.frame = CGRectMake(10 , 15 , 100 , 100);
    }
    
    //ImageView變圓形
    self.ImageView.layer.cornerRadius = self.ImageView.frame.size.height/8;
    self.ImageView.layer.masksToBounds = YES;
    self.ImageView.layer.borderWidth = 0;
    
    //ContentView裡面加入剛設定的ImageView
    [self.ContentView addSubview:self.ImageView];
    
    //ContentView裡面創建TextLabel
    //職位 TextLabel
    self.YearLabel = [[UILabel alloc] init];
    self.YearLabel.frame = CGRectMake(self.ImageView.frame.size.width + 20, 15, 80, 20);
    //假資料 (會員職位)
    self.YearLabel.text = @"教職員工";
    self.YearLabel.font = [self.YearLabel.font fontWithSize:15];
    self.YearLabel.textColor = [UIColor lightGrayColor];
    self.YearLabel.adjustsFontSizeToFitWidth = YES;
    //ContentView裡面加入剛設定的Label
    [self.ContentView addSubview:self.YearLabel];
    
    
    //Name TextLabel
    self.NameLabel = [[UILabel alloc] init];
    self.NameLabel.frame = CGRectMake(self.ImageView.frame.size.width + 20, 50, 100, 30);
    //假資料 (會員名稱)
    self.NameLabel.text = [NameArray objectAtIndex:Membercount];
    self.NameLabel.font = [self.NameLabel.font fontWithSize:25];
    self.NameLabel.adjustsFontSizeToFitWidth = YES;
    //ContentView裡面加入剛設定的Label
    [self.ContentView addSubview:self.NameLabel];
    

    //保留 TextLabel (目前空白)
    self.AdressLabel = [[UILabel alloc] init];
    if (self.view.frame.size.width == 320) {
        self.AdressLabel.frame = CGRectMake(self.ImageView.frame.size.width + 20, 60, 140, 50);
    }else{
        self.AdressLabel.frame = CGRectMake(self.ImageView.frame.size.width + 20, 60, 170, 60);
    }
    self.AdressLabel.text = @"  ";
    self.AdressLabel.numberOfLines = 0;
    self.AdressLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.AdressLabel.font = [self.AdressLabel.font fontWithSize:12];
    self.AdressLabel.textColor = [UIColor lightGrayColor];
    self.AdressLabel.adjustsFontSizeToFitWidth = YES;
    //ContentView裡面加入剛設定的Label
    [self.ContentView addSubview:self.AdressLabel];
    
    
    
    //ContentView 裡創建 Button 用的ScrollView
    //創建ScrollView
    self.ButtonScrollView = [[UIScrollView alloc] init];
    //ScrollView圓角設定
    self.ButtonScrollView.layer.cornerRadius = 20;
    
    
    if (self.view.frame.size.width == 320) {
        //ButtonScrollView長高設定
         self.ButtonScrollView.frame = CGRectMake(0, self.ImageView.frame.size.height + 30, scrollWidth-70, self.ContentView.frame.size.height-(self.ImageView.frame.size.height + 20));
        self.ButtonScrollView.contentSize = CGSizeMake(scrollWidth-70,360);
        
    }else{
        self.ButtonScrollView.frame = CGRectMake(0, self.ImageView.frame.size.height + 20, scrollWidth-10, self.ContentView.frame.size.height-(self.ImageView.frame.size.height + 30));
        
        self.ButtonScrollView.contentSize = CGSizeMake(scrollWidth-10,360);
    }
    
    
    //ButtonScrollView背景顏色
    self.ButtonScrollView.backgroundColor = [UIColor whiteColor];
    //ButtonScrollView設定
    self.ButtonScrollView.showsVerticalScrollIndicator = NO;
    self.ButtonScrollView.scrollEnabled = YES;
    self.ButtonScrollView.pagingEnabled = YES;
    self.ButtonScrollView.clipsToBounds = YES;
    self.ButtonScrollView.bounces = YES;
    

    //ContentView裡面加入剛設定的ButtonScrollView
    [self.ContentView addSubview:self.ButtonScrollView];
    
    
    
    //ContentView裡創建第一個Button
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    //Button圖片設定
    UIImage *buttonImage = [UIImage imageNamed:@"backgroundLine" ];
    [self.button setImage:buttonImage forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        //Button長高大小設定
        self.button.frame = CGRectMake(15, 0, 200, 30);
    }else{
        self.button.frame = CGRectMake(15, 0, 260 , 30);
    }
    //Button 動作設定 "goToLevel" Funtion
    [self.button addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    //ButtonScrollView裡面加入剛設定的Button
    [self.ButtonScrollView addSubview:self.button];
    

    ///////////////////////////////
    //ContentView裡創建第二個Button
    self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //Button Tag 按鈕的代號(為了判斷哪個按鈕被按了)
    self.button1.tag = 1;
    //Button圖片設定
    UIImage *buttonImage2 = [UIImage imageNamed:@"id-card" ];
    [self.button1 setImage:buttonImage2 forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        //Button長高大小設定
        self.button1.frame = CGRectMake(15, 30, 60, 60);
    }else{
        self.button1.frame = CGRectMake(15, 30, 75, 75);
    }
    
    //Button 動作設定 "goToLevel" Funtion
    [self.button1 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    //ButtonScrollView裡面加入剛設定的Button
    [self.ButtonScrollView addSubview:self.button1];
    
    
    //創建Button底下的Label文字
    self.ButtonLabel1 = [[UILabel alloc] init];
    self.ButtonLabel1.text = @"會員管理";
    self.ButtonLabel1.font = [self.ButtonLabel1.font fontWithSize:14];
    self.ButtonLabel1.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel1.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel1.frame = CGRectMake(15, 70, 60, 60);
    }else{
        self.ButtonLabel1.frame = CGRectMake(15, 80, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel1];

    //////////////////////////////////////
    //跟上面雷同
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.tag = 2;
    UIImage *buttonImage3 = [UIImage imageNamed:@"class" ];
    [self.button2 setImage:buttonImage3 forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        self.button2.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 30, 60, 60);
    }else{
        self.button2.frame = CGRectMake((scrollWidth-10)/2-75/2, 30, 75, 75);
    }
    [self.button2 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button2];
    
    self.ButtonLabel2 = [[UILabel alloc] init];
    self.ButtonLabel2.text = @"課程管理";
    self.ButtonLabel2.font = [self.ButtonLabel2.font fontWithSize:14];
    self.ButtonLabel2.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel2.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel2.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 70, 60, 60);
    }else{
        self.ButtonLabel2.frame = CGRectMake((scrollWidth-10)/2-75/2, 80, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel2];
    
    /////////////////////////////////////
    
    //跟上面雷同
    self.button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button3.tag = 3;
    UIImage *buttonImage4 = [UIImage imageNamed:@"orders" ];
    [self.button3 setImage:buttonImage4 forState:UIControlStateNormal];
    if (self.view.frame.size.width == 320) {
        self.button3.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 30, 60, 60);
    }else{
        self.button3.frame = CGRectMake((scrollWidth-10-15-75), 30, 75, 75);
    }
    [self.button3 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button3];
    
    
//    self.ButtonLabel3 = [[UILabel alloc] init];
//    self.ButtonLabel3.text = @"訂單管理";
//    self.ButtonLabel3.font = [self.ButtonLabel3.font fontWithSize:14];
//    self.ButtonLabel3.adjustsFontSizeToFitWidth = YES;
//    self.ButtonLabel3.textAlignment = NSTextAlignmentCenter;
//    if (self.view.frame.size.width == 320) {
//        self.ButtonLabel3.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 70, 60, 60);
//    }else{
//        self.ButtonLabel3.frame = CGRectMake((scrollWidth-10-15-75), 80, 75, 75);
//    }
//    
//    
//    [self.ButtonScrollView addSubview:self.ButtonLabel3];
    
    /////////////////////////////////////
    
    
    //跟上面雷同
    self.button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button4.tag = 4;
    UIImage *buttonImage5 = [UIImage imageNamed:@"employee" ];
    [self.button4 setImage:buttonImage5 forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        self.button4.frame = CGRectMake(15, 120, 60, 60);
    }else{
        self.button4.frame = CGRectMake(15, 140, 75, 75);
    }
    [self.button4 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button4];
    
    
    self.ButtonLabel4 = [[UILabel alloc] init];
    self.ButtonLabel4.text = @"出缺勤管理";
    self.ButtonLabel4.font = [self.ButtonLabel4.font fontWithSize:14];
    self.ButtonLabel4.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel4.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel4.frame = CGRectMake(15, 160, 60, 60);
    }else{
        self.ButtonLabel4.frame = CGRectMake(15, 190, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel4];
    
    /////////////////////////////////////

    //跟上面雷同
    self.button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button5.tag = 5;
    UIImage *buttonImage6 = [UIImage imageNamed:@"calendar"];
    [self.button5 setImage:buttonImage6 forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        self.button5.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 120, 60, 60);
    }else{
        self.button5.frame = CGRectMake((scrollWidth-10)/2-75/2, 140, 75, 75);
    }
    [self.button5 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button5];
    
    
    self.ButtonLabel5 = [[UILabel alloc] init];
    self.ButtonLabel5.text = @"行事曆";
    self.ButtonLabel5.font = [self.ButtonLabel5.font fontWithSize:14];
    self.ButtonLabel5.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel5.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel5.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 160, 60, 60);
    }else{
        self.ButtonLabel5.frame = CGRectMake((scrollWidth-10)/2-75/2, 190, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel5];
    
    
    
    
    
    /////////////////////////////////////
    //跟上面雷同
    self.button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button6.tag = 6;
    UIImage *buttonImage7 = [UIImage imageNamed:@"health1"];
    [self.button6 setImage:buttonImage7 forState:UIControlStateNormal];
    
    if (self.view.frame.size.width == 320) {
        self.button6.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 120, 60, 60);
    }else{
        self.button6.frame = CGRectMake((scrollWidth-10-15-75), 140, 75, 75);
    }
    [self.button6 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button6];
    
    
    self.ButtonLabel6 = [[UILabel alloc] init];
    self.ButtonLabel6.text = @"健康資訊";
    self.ButtonLabel6.font = [self.ButtonLabel6.font fontWithSize:14];
    self.ButtonLabel6.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel6.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel6.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 160, 60, 60);
    }else{
        self.ButtonLabel6.frame = CGRectMake((scrollWidth-10-15-75), 190, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel6];

    

    
    /////////////////////////////////////
    
    //跟上面雷同
    self.button7 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button7.tag = 7;
    UIImage *buttonImage8 = [UIImage imageNamed:@"Log" ];
    [self.button7 setImage:buttonImage8 forState:UIControlStateNormal];
    if (self.view.frame.size.width == 320) {
        self.button7.frame = CGRectMake(15, 210, 60, 60);
    }else{
        self.button7.frame = CGRectMake(15, 250, 75, 75);
    }
    
    
    [self.button7 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button7];
    
    self.ButtonLabel7 = [[UILabel alloc] init];
    self.ButtonLabel7.text = @"互動日誌";
    self.ButtonLabel7.font = [self.ButtonLabel7.font fontWithSize:14];
    self.ButtonLabel7.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel7.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel7.frame = CGRectMake(15, 250, 60, 60);
    }else{
        self.ButtonLabel7.frame = CGRectMake(15, 300, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel7];

    
    /////////////////////////////////////////////
    //跟上面雷同
    self.button8 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button8.tag = 8;
    UIImage *buttonImage9 = [UIImage imageNamed:@"communicate" ];
    [self.button8 setImage:buttonImage9 forState:UIControlStateNormal];
    if (self.view.frame.size.width == 320) {
        self.button8.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 210, 60, 60);
    }else{
        self.button8.frame = CGRectMake((scrollWidth-10)/2-75/2, 250, 75, 75);
    }
    
    
    [self.button8 addTarget:self
                     action:@selector(goToLevel:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonScrollView addSubview:self.button8];
    
    self.ButtonLabel8 = [[UILabel alloc] init];
    self.ButtonLabel8.text = @"意見交流";
    self.ButtonLabel8.font = [self.ButtonLabel8.font fontWithSize:14];
    self.ButtonLabel8.adjustsFontSizeToFitWidth = YES;
    self.ButtonLabel8.textAlignment = NSTextAlignmentCenter;
    if (self.view.frame.size.width == 320) {
        self.ButtonLabel8.frame = CGRectMake((self.ContentView.frame.size.width-10)/2-50/2, 250, 60, 60);
    }else{
        self.ButtonLabel8.frame = CGRectMake((scrollWidth-10)/2-75/2, 300, 75, 75);
    }
    
    
    [self.ButtonScrollView addSubview:self.ButtonLabel8];
    
    
    /////////////////////////////////////////////
    //跟上面雷同 第9個按鈕
//    self.button9 = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.button9.tag = 9;
//    UIImage *buttonImage10 = [UIImage imageNamed:@"message" ];
//    [self.button9 setImage:buttonImage10 forState:UIControlStateNormal];
//    if (self.view.frame.size.width == 320) {
//        self.button9.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 210, 60, 60);
//    }else{
//        self.button9.frame = CGRectMake((scrollWidth-10-15-75), 250, 75, 75);
//    }
//    
//    
//    [self.button9 addTarget:self
//                     action:@selector(goToLevel:)
//           forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.ButtonScrollView addSubview:self.button9];
//    
//    self.ButtonLabel9 = [[UILabel alloc] init];
//    self.ButtonLabel9.text = @"即時訊息";
//    self.ButtonLabel9.font = [self.ButtonLabel8.font fontWithSize:14];
//    self.ButtonLabel9.adjustsFontSizeToFitWidth = YES;
//    self.ButtonLabel9.textAlignment = NSTextAlignmentCenter;
//    if (self.view.frame.size.width == 320) {
//        self.ButtonLabel9.frame = CGRectMake((self.ContentView.frame.size.width-15-60), 250, 60, 60);
//    }else{
//        self.ButtonLabel9.frame = CGRectMake((scrollWidth-10-15-75), 300, 75, 75);
//    }
//    
//    [self.ButtonScrollView addSubview:self.ButtonLabel9];
//
    
    
    
    
    
    
    //ScrollView加入創建好的ContentView
    [self.ScrollView addSubview:self.ContentView];
    
    

    
    
}

//按鈕動作 "goToLevel" Funtion
-(void)goToLevel:(UIButton *)sender{
    
    NSLog(@"Button tag :%ld",(long)sender.tag);
    
    //上面有給每個Button設定Tag編號
    
    //Button Tag 是 1 的
    if (sender.tag == 1) {
        
        //跳轉到 storyboard裡 名字是"matter"的ControllerView
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"matter"];
        //ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

    //Button Tag 是 2 的
    }else if (sender.tag ==2){
        //跳轉到 storyboard裡 名字是"babyservice"的ControllerView
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"babyservice"];
        [self.navigationController pushViewController:ViewController animated:YES];

        
    //Button Tag 是 3 的
    }else if (sender.tag ==3){
        
        //跳轉到OrderViewController
        OrderViewController *ViewController = [[OrderViewController alloc] init];
        //ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
    
    //Button Tag 是 4 的
    }else if (sender.tag ==4){
        
        //跳轉到EmployeeServiceViewController
        EmployeeServiceViewController *ViewController = [[EmployeeServiceViewController alloc] init];
        //ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
    //Button Tag 是 5 的
    }else if (sender.tag ==5){
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"calendar"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    //Button Tag 是 6 的
    }else if (sender.tag ==6){
        
        HealthViewController *ViewController = [[HealthViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    //Button Tag 是 7 的
    }else if (sender.tag ==7){
        
        LogViewController *ViewController = [[LogViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
    //Button Tag 是 8 的
    }else if (sender.tag ==8){
        
        OpinionTableViewController *ViewController = [[OpinionTableViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
        
    }
    
    
}



//PageView跟ScrollView連接設定 (目前用不到)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.PageView.currentPage = (NSInteger)(scrollView.contentOffset.x / self.ScrollView.frame.size.width + 0.5);
    
}


@end
