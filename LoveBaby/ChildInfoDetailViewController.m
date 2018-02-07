//
//  ChildInfoDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ChildInfoDetailViewController.h"

@interface ChildInfoDetailViewController ()

@end

@implementation ChildInfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(ChildFinish:)];
    
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    
    ChildMemory = [NSUserDefaults standardUserDefaults];
    
    if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildName"]) {
        
        if ([[ChildMemory objectForKey:@"add"]isEqualToString:@"add"]) {
            self.ChildText.text = [ChildMemory objectForKey:@"ChildAddName"];
        }else{
            self.ChildText.text = [ChildMemory objectForKey:@"ChildInfoName"];
        }
        
        self.ChildText.placeholder = @"請輸入兒童姓名";
        self.ChildText.hidden = NO;
        self.ChildSexTable.hidden = YES;
        self.ChildLabel.hidden = YES;
        self.ChildDateView.hidden = YES;
        
    }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildSex"]){
        
        self.ChildText.hidden = YES;
        self.ChildSexTable.hidden = NO;
        self.ChildLabel.hidden = YES;
        self.ChildDateView.hidden = YES;
        
    }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildId"]){
        
        if ([[ChildMemory objectForKey:@"add"]isEqualToString:@"add"]) {
            self.ChildText.text = [ChildMemory objectForKey:@"ChildAddId"];
        }else{
            self.ChildText.text = [ChildMemory objectForKey:@"ChildInfoId"];
        }

        
        self.ChildText.placeholder = @"請輸入兒童身份證字號";
        self.ChildText.hidden = NO;
        self.ChildSexTable.hidden = YES;
        self.ChildLabel.hidden = YES;
        self.ChildDateView.hidden = YES;
        
    }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildBirthday"]){
        
        //設定時間
        NSString *str;
        if ([[ChildMemory objectForKey:@"add"]isEqualToString:@"add"]) {
            str = [ChildMemory objectForKey:@"ChildAddDate"];
        }else{
            str = [ChildMemory objectForKey:@"ChildInfoDate"];
        }
        
        if (str == nil) {
            str = @"1993-06-16";
        }

        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        NSDate *date = [dateFormat dateFromString:str];
        [self.ChildDatePickView setDate:date animated:YES];
        
        self.ChildText.hidden = YES;
        self.ChildSexTable.hidden = YES;
        self.ChildLabel.hidden = NO;
        self.ChildDateView.hidden = NO;
        
    }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildText"]){
        
        if ([[ChildMemory objectForKey:@"add"]isEqualToString:@"add"]) {
            self.ChildText.text = [ChildMemory objectForKey:@"ChildAddText"];
        }else{
            self.ChildText.text = [ChildMemory objectForKey:@"ChildInfoText"];
        }

        
        self.ChildText.placeholder = @"請輸入備註";
        self.ChildText.hidden = NO;
        self.ChildSexTable.hidden = YES;
        self.ChildLabel.hidden = YES;
        self.ChildDateView.hidden = YES;
    }
    
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
        
        //列表顯示的型態
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier];    }
    
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
        ChildSex = @"男";
    }else if (indexPath.row == 1){
        ChildSex = @"女";
    }
    
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *oldIndex = [self.ChildSexTable indexPathForSelectedRow];
    [self.ChildSexTable cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
    [self.ChildSexTable cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    return indexPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)ChildFinish:(id)sender{
    
    
    //新增小孩資料
    if ([[ChildMemory objectForKey:@"add"] isEqualToString:@"add"]) {
        
        if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildName"]) {
            
            [ChildMemory setObject:self.ChildText.text forKey:@"ChildAddName"];
            NSLog(@"%@",self.ChildText.text);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildSex"]){
            
            [ChildMemory setObject:ChildSex forKey:@"ChildAddSex"];
            NSLog(@"%@",ChildSex);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildId"]){
            
            [ChildMemory setObject:self.ChildText.text forKey:@"ChildAddId"];
            NSLog(@"%@",self.ChildText.text);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildBirthday"]){
            
            
            NSString *ChildDate = [NSString stringWithFormat:@"%@",self.ChildDatePickView.date];
            //設定時間
            NSString *str2 = [ChildDate substringWithRange:NSMakeRange(8, 2)];
            //時間轉換
            int dateint = [str2 intValue] + 1;
            NSString *dateStr = [ChildDate stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:[NSString stringWithFormat:@"%d",dateint]];
            
            [ChildMemory setObject:[dateStr substringToIndex:10] forKey:@"ChildAddDate"];
            
            NSLog(@"%@",[dateStr substringToIndex:10]);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildText"]){
            
            [ChildMemory setObject:self.ChildText.text forKey:@"ChildAddText"];
            NSLog(@"%@",self.ChildText.text);
            
        }
        
        //發出廣播端
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChildDetailReload" object:self userInfo:nil];
        
        
        
        //修改小孩資料
    }else{
        
        //(需要改)
        if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildName"]) {
            
            NSLog(@"%@",self.ChildText.text);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildSex"]){
            
            NSLog(@"%@",ChildSex);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildId"]){
            
            NSLog(@"%@",self.ChildText.text);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildBirthday"]){
            
            NSString *ChildDate = [NSString stringWithFormat:@"%@",self.ChildDatePickView.date];
            //設定時間
            NSString *str2 = [ChildDate substringWithRange:NSMakeRange(8, 2)];
            //時間轉換
            int dateint = [str2 intValue] + 1;
            NSString *dateStr = [ChildDate stringByReplacingCharactersInRange:NSMakeRange(8, 2) withString:[NSString stringWithFormat:@"%d",dateint]];
            
            NSLog(@"%@",[dateStr substringToIndex:10]);
            
        }else if ([[ChildMemory objectForKey:@"ChildInfo"] isEqualToString:@"ChildText"]){
            
            NSLog(@"%@",self.ChildText.text);
            
        }
        
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}





@end
