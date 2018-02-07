//
//  MainViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate>{
    NSUserDefaults *UserMemory;
    NSArray *contentList;
    NSMutableArray *NameArray;
}


@property (strong, nonatomic) IBOutlet UIView *ContentView;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *ButtonScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *PageView;

@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *YearLabel;
@property (strong, nonatomic) IBOutlet UILabel *AdressLabel;
@property (strong,nonatomic) UIButton *button;
@property (strong,nonatomic) UIButton *button1;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel1;
@property (strong,nonatomic) UIButton *button2;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel2;
@property (strong,nonatomic) UIButton *button3;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel3;
@property (strong,nonatomic) UIButton *button4;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel4;
@property (strong,nonatomic) UIButton *button5;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel5;
@property (strong,nonatomic) UIButton *button6;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel6;
@property (strong,nonatomic) UIButton *button7;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel7;
@property (strong,nonatomic) UIButton *button8;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel8;
@property (strong,nonatomic) UIButton *button9;
@property (strong, nonatomic) IBOutlet UILabel *ButtonLabel9;
@end
