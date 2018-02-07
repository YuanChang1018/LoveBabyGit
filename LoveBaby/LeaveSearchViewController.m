//
//  LeaveSearchViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/29.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LeaveSearchViewController.h"
#import "LeaveSearchTableViewCell.h"
#import "LeaveResultViewController.h"
#import "MMPickerView.h"

@interface LeaveSearchViewController ()

@end

@implementation LeaveSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"假單查詢";
    
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"LeaveSearchReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.LeaveSearchTableView reloadData];
    NSLog(@"LeaveSearchReload");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.LeaveSearchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeaveSearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LeaveSearchTableViewCell class])];
    
    LeaveMemory = [NSUserDefaults standardUserDefaults];
    
    SearchLeaveQuesArray = [[NSMutableArray alloc] init];
    SearchLeaveAnsArray = [[NSMutableArray alloc] init];
    YearArray = [[NSMutableArray alloc] init];
    MonthArray = [[NSMutableArray alloc] init];
    DayArray = [[NSMutableArray alloc] init];

    
    
    //Question
    [SearchLeaveQuesArray addObject:@"年："];
    [SearchLeaveQuesArray addObject:@"月："];
    [SearchLeaveQuesArray addObject:@"日："];
    
    
    
    //Question Option Array
    //年
    [YearArray addObject:@"無"];
    [YearArray addObject:@"2017"];
    [YearArray addObject:@"2018"];
    [YearArray addObject:@"2019"];
    
    //月
    [MonthArray addObject:@"無"];
    [MonthArray addObject:@"1月"];
    [MonthArray addObject:@"2月"];
    [MonthArray addObject:@"3月"];
    [MonthArray addObject:@"4月"];
    [MonthArray addObject:@"5月"];
    [MonthArray addObject:@"6月"];
    [MonthArray addObject:@"7月"];
    [MonthArray addObject:@"8月"];
    [MonthArray addObject:@"9月"];
    [MonthArray addObject:@"10月"];
    [MonthArray addObject:@"11月"];
    [MonthArray addObject:@"12月"];
    
    //日
    [DayArray addObject:@"無"];
    
    
    ///初始化AnsArray設定
    [SearchLeaveAnsArray addObject:[YearArray objectAtIndex:0]];
    [SearchLeaveAnsArray addObject:[MonthArray objectAtIndex:0]];
    [SearchLeaveAnsArray addObject:[DayArray objectAtIndex:0]];
    
    
    //初始化LeaveMemory
    [LeaveMemory setObject:[YearArray objectAtIndex:0] forKey:@"LeaveYear"];
    [LeaveMemory setObject:[MonthArray objectAtIndex:0] forKey:@"LeaveMonth"];
    [LeaveMemory setObject:[DayArray objectAtIndex:0] forKey:@"LeaveDay"];
   

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [SearchLeaveQuesArray count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaveSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeaveSearchTableViewCell class]) forIndexPath:indexPath];
    
    
    if (indexPath.row == 0) {
        
        cell.SearchCellQuesLabel.text = [SearchLeaveQuesArray objectAtIndex:0];
        cell.SearchCellAnsLabel.text = [SearchLeaveAnsArray objectAtIndex:0];
        
    }else if (indexPath.row == 1) {
        
        cell.SearchCellQuesLabel.text = [SearchLeaveQuesArray objectAtIndex:1];
        cell.SearchCellAnsLabel.text = [SearchLeaveAnsArray objectAtIndex:1];
        
        if ([[LeaveMemory objectForKey:@"LeaveYear"]isEqualToString:@"無"]){
            cell.SearchCellQuesLabel.textColor = [UIColor lightGrayColor];
            cell.SearchCellAnsLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.SearchCellQuesLabel.textColor = [UIColor blackColor];
            cell.SearchCellAnsLabel.textColor = [UIColor blackColor];
        }
        
        
    }else if (indexPath.row == 2) {
        
        cell.SearchCellQuesLabel.text = [SearchLeaveQuesArray objectAtIndex:2];
        cell.SearchCellAnsLabel.text = [SearchLeaveAnsArray objectAtIndex:2];
        
        if ([[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"無"]){
            cell.SearchCellQuesLabel.textColor = [UIColor lightGrayColor];
            cell.SearchCellAnsLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.SearchCellQuesLabel.textColor = [UIColor blackColor];
            cell.SearchCellAnsLabel.textColor = [UIColor blackColor];
        }
        
        
        
    }
    

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaveSearchReload" object:self userInfo:nil];
    
    
    if (indexPath.row == 0) {
        
        if ([LeaveMemory objectForKey:@"LeaveYear"] == nil) {
            
            SelectedString = [YearArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [LeaveMemory objectForKey:@"LeaveYear"];
            
        }
        
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:YearArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    
                                    [SearchLeaveAnsArray replaceObjectAtIndex:0 withObject:selectedString];
                                    [LeaveMemory setObject:selectedString forKey:@"LeaveYear"];
                                    
                                }
         ];
        

    }
    
    
    if (indexPath.row == 1) {
        
        if ([LeaveMemory objectForKey:@"LeaveMonth"] == nil) {
            
            SelectedString = [MonthArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [LeaveMemory objectForKey:@"LeaveMonth"];
            
        }
        
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:MonthArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    
                                    [SearchLeaveAnsArray replaceObjectAtIndex:1 withObject:selectedString];
                                    [LeaveMemory setObject:selectedString forKey:@"LeaveMonth"];
                                    
                                    DayArray = [[NSMutableArray alloc] init];
                                    [DayArray addObject:@"無"];
                                    
                                    if ([[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"2月"]) {
                                        NSString *day;
                                        for (int i =1 ; i<29; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                    }else if ([[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"1月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"3月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"2月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"5月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"7月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"8月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"10月"]||[[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"12月"]){
                                        
                                        NSString *day;
                                        for (int i =1 ; i<32; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                    }else{
                                        
                                        NSString *day;
                                        for (int i =1 ; i<31; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                        
                                    }

                                }
         ];
        
        
    }

    
    if (indexPath.row == 2) {
        
        if ([LeaveMemory objectForKey:@"LeaveDay"] == nil) {
            
            SelectedString = [DayArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [LeaveMemory objectForKey:@"LeaveDay"];
            
        }
        
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:DayArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    
                                    [SearchLeaveAnsArray replaceObjectAtIndex:2 withObject:selectedString];
                                    [LeaveMemory setObject:selectedString forKey:@"LeaveDay"];
                                    
                                }
         ];
        
        
    }


}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    
    if (path.row == 1) {
        if ([[LeaveMemory objectForKey:@"LeaveYear"]isEqualToString:@"無"]) {
            
            return nil;
            
        }else{
            
            return path;
            
        }
        
    }
    
    if (path.row == 2) {
        if ([[LeaveMemory objectForKey:@"LeaveMonth"]isEqualToString:@"無"]) {
            
            return nil;
            
        }else{
            
            return path;
            
        }
        
    }
    
    return path;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (self.view.frame.size.width == 320) {
        
        return 60;
        
    }else{
        
        return 80;
    }
}

- (IBAction)LeaveSearchButton:(id)sender {
    
    NSLog(@"年：%@",[LeaveMemory objectForKey:@"LeaveYear"]);
    NSLog(@"月：%@",[LeaveMemory objectForKey:@"LeaveMonth"]);
    NSLog(@"日：%@",[LeaveMemory objectForKey:@"LeaveDay"]);
    
    
    LeaveResultViewController *ViewController = [[LeaveResultViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
    
}
@end
