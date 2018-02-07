//
//  LeaveViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LeaveViewController.h"
#import "LeaveTableViewCell.h"
#import "MMPickerView.h"
#import "SCLAlertView.h"

@interface LeaveViewController ()

@end

@implementation LeaveViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"假單輸入";
    self.BackgroundView.hidden = YES;
    self.DateView.hidden = YES;
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"LeaveReload" object:nil];
    
    
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.LeaveTableView reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.LeaveTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeaveTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LeaveTableViewCell class])];
    
    LeaveQuesArray = [[NSMutableArray alloc] init];
    leaveAnsArray = [[NSMutableArray alloc] init];
    LeaveTypeArray = [[NSMutableArray alloc] init];
        
    
   
    
      
    
    NSLocale *datelocale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_TW"];
    self.DatePickerView.locale = datelocale;
    self.DatePickerView.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    
    //Question
    [LeaveQuesArray addObject:@"開始日期："];
    [LeaveQuesArray addObject:@"結束日期："];
    [LeaveQuesArray addObject:@"假別："];
    [LeaveQuesArray addObject:@"原因："];
    
    [LeaveTypeArray addObject:@"病假"];
    [LeaveTypeArray addObject:@"事假"];
    [LeaveTypeArray addObject:@"公假"];
    
    //Answer
    [leaveAnsArray addObject:@""];
    [leaveAnsArray addObject:@""];
    [leaveAnsArray addObject:@""];
    [leaveAnsArray addObject:@""];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [LeaveQuesArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeaveTableViewCell class]) forIndexPath:indexPath];
    
    cell.LeaveCellAnsLabel.adjustsFontSizeToFitWidth = YES;
    cell.LeaveCellQnsLabel.text = [LeaveQuesArray objectAtIndex:indexPath.row];
    cell.LeaveCellAnsLabel.text = [leaveAnsArray objectAtIndex:indexPath.row];
    if (indexPath.row == 2) {
        
        [cell.LeaveCellAnsLabel setFont:[UIFont systemFontOfSize:18]];
    
    }
    
    
        
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaveReload" object:self userInfo:nil];
    
    if (indexPath.row == 0) {
        self.BackgroundView.hidden = NO;
        self.DateView.hidden = NO;
        self.DateFinishButton.tag = 0;
        self.DatePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    }
    
    if (indexPath.row == 1) {
        self.BackgroundView.hidden = NO;
        self.DateView.hidden = NO;
        self.DateFinishButton.tag = 1;
        self.DatePickerView.datePickerMode = UIDatePickerModeDateAndTime;
        
    }
    
    if (indexPath.row == 2) {

        SelectedString = [LeaveTypeArray objectAtIndex:0];
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                           withStrings:LeaveTypeArray      //設定PickView和toolbar顏色、字型大小
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:28],
                                         MMvalueY: @3,
                                         MMselectedObject:SelectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString) {
                                
                                [leaveAnsArray replaceObjectAtIndex:2 withObject:selectedString];
                               
                                
                            }
        ];

    }
    
    if (indexPath.row == 3) {
        
        //初始化提示框
        self.alert = [UIAlertController alertControllerWithTitle:@"請假原因" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        //增加提示輸入文字框
        [self.alert addTextFieldWithConfigurationHandler:^(UITextField *_Nonnull textField){
            textField.keyboardType = UIKeyboardTypeDefault;
        }];

        //增加提示按鈕
        [self.alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
        
        }]];
        
        //增加提示按鈕
        [self.alert addAction:[UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            
            UITextField *textField = [[self.alert textFields] firstObject];
            [leaveAnsArray replaceObjectAtIndex:3 withObject:textField.text];
            NSLog(@"%@",textField.text);
            
            //發出廣播端
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaveReload" object:self userInfo:nil];
            
        }]];
        
        //彈出提示框
        [self presentViewController:self.alert animated:true completion:nil];
        
    }
    

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (self.view.frame.size.width == 320) {
        
        return 60;
        
    }else{
        
        return 80;
    }
}



- (IBAction)DateFinishButton:(id)sender {
    self.BackgroundView.hidden = YES;
    self.DateView.hidden = YES;
    
    NSString *LeaveStartDateTime = [NSString stringWithFormat:@"%@",self.DatePickerView.date];
    NSString *Date;
    NSString *Time;
    
    
    Date = [LeaveStartDateTime substringWithRange:NSMakeRange(0, 11)];
    Time = [LeaveStartDateTime substringWithRange:NSMakeRange(11, 5)];
    
    
    if ([sender tag] == 0) {
        
        StartDate = Date;
        StartTime = Time;
        
        [leaveAnsArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@ %@",StartDate,StartTime]];
        
    }else if ([sender tag] == 1){
        
        EndDate = Date;
        EndTime = Time;
        
        [leaveAnsArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@ %@",EndDate,EndTime]];
        
    }
    
    [self.LeaveTableView reloadData];
    
    
}


- (IBAction)LeaveButton:(id)sender {
    
    NSLog(@"StartDate:%@",StartDate);
    NSLog(@"StartTime:%@",StartTime);
    NSLog(@"EndDate:%@",EndDate);
    NSLog(@"EndTime:%@",EndTime);
    NSLog(@"Type:%@",[leaveAnsArray objectAtIndex:2]);
    NSLog(@"Reason:%@",[leaveAnsArray objectAtIndex:3]);
    
}
@end
