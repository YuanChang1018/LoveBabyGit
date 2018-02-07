//
//  BabyServiceViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "BabyServiceViewController.h"
#import "BabyServiceTableViewCell.h"
#import "ClassSearchViewController.h"
#import "OwnClassViewController.h"
#import "NamedViewController.h"
#import "SCLAlertView.h"


@interface BabyServiceViewController ()

@end

@implementation BabyServiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"MemberReload" object:nil];
    
    
    self.navigationItem.title = @"課程管理";
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    //[self viewDidLoad];
    [self.BabyServiceTable reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UserMemory = [NSUserDefaults standardUserDefaults];
    
    BabyFeaturesArray = [[NSMutableArray alloc] init];
    [BabyFeaturesArray addObject:@"新課程查詢"];
    [BabyFeaturesArray addObject:@"已選課程"];
    //[BabyFeaturesArray addObject:@"上課點名"];
    
    BabyFeaturesImageArray = [[NSMutableArray alloc]init];
    [BabyFeaturesImageArray addObject:@"searchclass"];
    [BabyFeaturesImageArray addObject:@"classsave"];
    [BabyFeaturesImageArray addObject:@"RaiseHand"];
    
    ChildNameArray = [[NSMutableArray alloc] init];
    
    //////////通知 選擇小孩身份 假資料
    //回到 LoginViewController 270行去看你設定的身份名稱
    //這裡以後確認使用者身份是"家長"身份的話 要放入小孩們名稱
    //[UserMemory objectForKey:@"identity"];   用這個去判斷身份
    
    //小孩陣列 抓取資料庫小孩名稱 塞進這個陣列
    if([[UserMemory objectForKey:@"identity"]isEqualToString:@"member"]){
        [ChildNameArray addObject:@"張小法"];
    }
    
    //Table BabyServiceTableViewCell 宣告
    [self.BabyServiceTable registerNib:[UINib nibWithNibName:NSStringFromClass([BabyServiceTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BabyServiceTableViewCell class])];
    
    
    
    //Alert通知宣告
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    
//    //小孩只有1位的話
//    if ([ChildNameArray count] == 1) {
//        
//        //只有一位的話創建1個按鈕
//        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
//    
//    //小孩有2位的話
//    }else if ([ChildNameArray count]==2){
//        
//        //兩位的話創建2個按鈕
//        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
//        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
//        
//    //小孩有3位的話
//    }else if ([ChildNameArray count]==3){
//        
//        //三位的話創建3個按鈕
//        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
//        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
//        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
//        
//    //小孩有4位的話
//    }else if ([ChildNameArray count]==4){
//        
//        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
//        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
//        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
//        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
//    
//    //小孩有5位的話
//    }else if ([ChildNameArray count]==5){
//        
//        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
//        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
//        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
//        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
//        [alert addButton:[ChildNameArray objectAtIndex:5] target:self selector:@selector(fifth) tag:5];
//    }
//    
//    
//    //Alert Title文字設定
//    [alert showInfo:self title:@"" subTitle:@"選擇小孩身份" closeButtonTitle:nil duration:0.0f];
    
    
    ///////////////////////////////////////////
    

}



//選取小孩身份 按鈕動作
- (void)first{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:0]);
    
}

- (void)second{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:1]);
    
}

- (void)third{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:2]);
    
}

- (void)fourth{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:3]);
    
}

- (void)fifth{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:4]);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <TableViewDelegate>
//TableView delegate設定

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [BabyFeaturesArray count];
    
    
}

//TableView Cell內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BabyServiceTableViewCell class]) forIndexPath:indexPath];
    
    [self.BabyServiceTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    cell.cellFrame = CGRectMake(10, 0, self.BabyServiceTable.frame.size.width - 20, 90);
    cell.backgroundColor = [UIColor whiteColor];
    cell.BabycellImage.image = [UIImage imageNamed:[BabyFeaturesImageArray objectAtIndex:indexPath.row]];
    cell.BabycellLabel.text = [BabyFeaturesArray objectAtIndex:indexPath.row];
    cell.BabycellLabel.textColor = [UIColor blackColor];
    cell.layer.cornerRadius = 10;
    
    return cell;
}


//Table Cell點選動作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        NSLog(@"課程查詢");
        
        //假資料 這是範例！！  假設身份是老師的話 跳出通知
        if ([[UserMemory objectForKey:@"identity"]isEqualToString:@"teacher"]) {
            
            //通知 沒帳號的話
            SCLAlertView *alert = [[SCLAlertView alloc] init];
            alert.shouldDismissOnTapOutside = YES;
            [alert showInfo:self title:@"" subTitle:@"教師無法使用此功能" closeButtonTitle:@"取消" duration:0.0f];
            
        }else{
            
            ClassSearchViewController *ViewController = [[ClassSearchViewController alloc] init];
            ViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ViewController animated:YES];
        }
        
        
    }else if (indexPath.row == 1){
        
        
        OwnClassViewController *ViewController = [[OwnClassViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController  animated:YES];
        
        
    }else if (indexPath.row == 2){
        
        NamedViewController *ViewController = [[NamedViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController  animated:YES];
        
        
    }
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MemberReload" object:self userInfo:nil];

    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

@end
