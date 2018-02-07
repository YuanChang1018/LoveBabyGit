//
//  UserDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.UserTextField.selected = YES;
    
    UserInfo = [NSUserDefaults standardUserDefaults];
    
    
    //判斷上一個view所選擇的欄位去做判斷要顯示什麼view
    if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"name"]) {
        self.UserTextField.placeholder = @"請輸入姓名";
        self.UserTextField.text = [UserInfo objectForKey:@"UserName"];
        
        self.navigationItem.title = @"名字";
        
        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"sex"]){
        self.UserTextField.placeholder = @"請輸入性別";
        self.UserTextField.text = [UserInfo objectForKey:@"UserSex"];
        
        self.navigationItem.title = @"性別";
        
        self.SexTable.hidden = NO;
        self.UserTextField.hidden = YES;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"id"]){
        self.UserTextField.placeholder = @"請輸入身份證";
        self.UserTextField.text = [UserInfo objectForKey:@"UserID"];
        self.navigationItem.title = @"身份證";
        
        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;

    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"birthday"]){
        self.UserTextField.placeholder = @"請輸入日期";
        self.UserTextField.text = [UserInfo objectForKey:@"UserBirthday"];
        self.navigationItem.title = @"日期";
        
        //設定時間
        NSString *str = [UserInfo objectForKey:@"UserBirthday"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        NSDate *date = [dateFormat dateFromString:str];
        [self.DatePickView setDate:date animated:YES];

        
        self.UserTextField.hidden = YES;
        self.DateView.hidden = NO;
        self.BirthdayLabel.hidden = NO;
        self.SexTable.hidden = YES;

        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"email"]){
        self.UserTextField.placeholder = @"請輸入電子郵件";
        self.UserTextField.text = [UserInfo objectForKey:@"UserEmail"];
        self.navigationItem.title = @"電子郵件";
        
        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;

    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"adress"]){
        self.UserTextField.placeholder = @"請輸入通訊地址";
        self.UserTextField.text = [UserInfo objectForKey:@"UserAdress"];
        self.navigationItem.title = @"通訊地址";
        
        self.UserTextField.font = [self.UserTextField.font fontWithSize:16];

        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;

    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"phone"]){
        self.UserTextField.placeholder = @"請輸入電話";
        self.UserTextField.text = [UserInfo objectForKey:@"UserPhone"];
        self.navigationItem.title = @"電話";
        
        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;

    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"englishname"]){
        self.UserTextField.placeholder = @"請輸入英文姓名";
        self.UserTextField.text = [UserInfo objectForKey:@"UserEnglishName"];
        self.navigationItem.title = @"英文姓名";
        
        self.UserTextField.hidden = NO;
        self.DateView.hidden = YES;
        self.BirthdayLabel.hidden = YES;
        self.SexTable.hidden = YES;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    //計算列表列數
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{  //列表的內容物
    
    NSString *simpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier]; //列表顯示的型態
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"男";
        cell.textLabel.font = [UIFont systemFontOfSize:18]; //改變列表字體大小
    }
    
    if (indexPath.row == 1) {
        
        cell.textLabel.text = @"女";
        cell.textLabel.font = [UIFont systemFontOfSize:18]; //改變列表字體大小
    }
    
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        Sex = @"男";
    }else if (indexPath.row == 1){
        Sex = @"女";
    }
    
    
    
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *oldIndex = [self.SexTable indexPathForSelectedRow];
    [self.SexTable cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
    [self.SexTable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    return indexPath;
}



//完成按鈕
- (IBAction)UserFinish:(id)sender {
    
    
    
    //依照選擇的儲存在使用者設定
    if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"name"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserName"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"englishname"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserEnglishName"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"sex"]) {
        
        [UserInfo setObject:Sex forKey:@"UserSex"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"birthday"]){
        
        NSString *Date = [NSString stringWithFormat:@"%@",self.DatePickView.date];
        
        //設定時間
        NSString *str = Date;
        NSString *str2 = [str substringWithRange:NSMakeRange(8, 2)];
        //時間轉換
        int dateint = [str2 intValue] + 1;
        NSString *dateStr = [str stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:[NSString stringWithFormat:@"%d",dateint]];
        
        [UserInfo setObject:[dateStr substringToIndex:10] forKey:@"UserBirthday"];
        
        NSLog(@"dateStr：%@",[dateStr substringToIndex:10]);
        
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"id"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserID"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"email"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserEmail"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"adress"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserAdress"];
        
    }else if ([[UserInfo objectForKey:@"UserInfo"] isEqualToString:@"phone"]) {
        
        [UserInfo setObject:self.UserTextField.text forKey:@"UserPhone"];
        
    }
    
    //發出廣播端 回上個view會重新整理
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:self userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
