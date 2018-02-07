//
//  EmployeeServiceViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "EmployeeServiceViewController.h"
#import "EmployeeServiceTableViewCell.h"
#import "LeaveRecordViewController.h"
#import "LeaveViewController.h"
#import "SCLAlertView.h"

@interface EmployeeServiceViewController ()

@end

@implementation EmployeeServiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"EmployeeReload" object:nil];
    
    
    self.navigationItem.title = @"假單管理";
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.EmployeeServiceTableView registerNib:[UINib nibWithNibName:NSStringFromClass([EmployeeServiceTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([EmployeeServiceTableViewCell class])];
    
    
    UserMemory = [NSUserDefaults standardUserDefaults];
    EmployeeServiceArray = [[NSMutableArray alloc] init];
    EmployeeImageArray = [[NSMutableArray alloc] init];
    
    [EmployeeServiceArray addObject:@"假單輸入"];
    //[EmployeeServiceArray addObject:@"假單查詢"];
    [EmployeeServiceArray addObject:@"假單紀錄"];
    
    [EmployeeImageArray addObject:@"LeaveInput"];
    [EmployeeImageArray addObject:@"LeaveSearch"];
    //[EmployeeImageArray addObject:@"LeaveRecord"];
    
    
    
    ChildNameArray = [[NSMutableArray alloc] init];
    
    
    //////////通知 選擇小孩身份 假資料
    //回到 LoginViewController 270行去看你設定的身份名稱
    //這裡以後確認使用者身份是"家長"身份的話 要放入小孩們名稱
    //[UserMemory objectForKey:@"identity"];   用這個去判斷身份
    
    //小孩陣列 抓取資料庫小孩名稱 塞進這個陣列
    if([[UserMemory objectForKey:@"identity"]isEqualToString:@"member"]){
        [ChildNameArray addObject:@"張小法"];
    }

    
    
    //Alert通知宣告
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    
    
    //小孩只有1位的話
    if ([ChildNameArray count] == 1) {
        
        //只有一位的話創建1個按鈕
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        
    //小孩有2位的話
    }else if ([ChildNameArray count]==2){
        
        //兩位的話創建2個按鈕
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
    
    //小孩有3位的話
    }else if ([ChildNameArray count]==3){
        
        //三位的話創建3個按鈕
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
     
    //小孩有4位的話
    }else if ([ChildNameArray count]==4){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
    
    //小孩有5位的話
    }else if ([ChildNameArray count]==5){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
        [alert addButton:[ChildNameArray objectAtIndex:5] target:self selector:@selector(fifth) tag:5];
    }
    
    
    //Alert Title文字設定
    [alert showInfo:self title:@"" subTitle:@"選擇小孩身份" closeButtonTitle:nil duration:0.0f];
    
    
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


//reload方法
-(void)reload:(NSNotification *)notification{
    
    //[self viewDidLoad];
    NSLog(@"EmployeeReload");
    [self.EmployeeServiceTableView reloadData];
}


#pragma mark <TableViewDelegate>
//TableView delegate設定

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [EmployeeServiceArray count];
    
    
}


//TableView Cell內容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    
    EmployeeServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EmployeeServiceTableViewCell class]) forIndexPath:indexPath];
    
    [self.EmployeeServiceTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    cell.cellFrame = CGRectMake(10, 0, self.EmployeeServiceTableView.frame.size.width - 20, 90);
    cell.backgroundColor = [UIColor whiteColor];
    cell.EmployCellImage.image = [UIImage imageNamed:[EmployeeImageArray objectAtIndex:indexPath.row]];
    cell.EmployCellLabel.text = [EmployeeServiceArray objectAtIndex:indexPath.row];
    cell.EmployCellLabel.textColor = [UIColor blackColor];
    cell.layer.cornerRadius = 10;
    
    return cell;
}


//Table Cell點選動作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        
        //假資料 這是範例！！  假設身份是老師的話
        if ([[UserMemory objectForKey:@"identity"]isEqualToString:@"teacher"]) {
            
            
            
        }else{
            
            
            
        }
        
        LeaveViewController *ViewController = [[LeaveViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
        
    }else if (indexPath.row == 1){
        
        LeaveRecordViewController *ViewController = [[LeaveRecordViewController alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
        
        
    }else if (indexPath.row == 2){
        
        
        
        
    }
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmployeeReload" object:self userInfo:nil];
    
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}




@end
