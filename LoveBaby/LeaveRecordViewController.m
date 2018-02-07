//
//  LeaveRecordViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/28.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LeaveRecordViewController.h"
#import "LeaveRecordTableViewCell.h"
#import "LeaveSearchViewController.h"
#import "LeaveDetailViewController.h"

@interface LeaveRecordViewController ()

@end

@implementation LeaveRecordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"假單紀錄";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"查詢" style:UIBarButtonItemStylePlain target:self action:@selector(LeaveSearch:)];
    Buttonitem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = Buttonitem;

    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"LeaveRecordReload" object:nil];
}




//查詢按鈕
-(IBAction)LeaveSearch:(id)sender{
    
    LeaveSearchViewController *ViewController = [[LeaveSearchViewController alloc] init];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
    
}



//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.LeaveRecordTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.LeaveRecordTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeaveRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LeaveRecordTableViewCell class])];
    
    LeaveDateArray = [[NSMutableArray alloc] init];
    LeaveNameArray = [[NSMutableArray alloc] init];
    LeaveStateArray = [[NSMutableArray alloc] init];
    
    [LeaveDateArray addObject:@"2017-03-12"];
    [LeaveDateArray addObject:@"2017-06-04"];
   
    
    
    [LeaveNameArray addObject:@"事假"];
    [LeaveNameArray addObject:@"病假"];
   
    
    
    
    [LeaveStateArray addObject:@"通過"];
    [LeaveStateArray addObject:@"通過"];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [LeaveNameArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            
            if (self.view.frame.size.width == 320) {
                
                sectionName = @"               日期             請假原因        審核狀態";
                
            }else if (self.view.frame.size.width == 375){
                
                sectionName = @"              日期               請假原因                  審核狀態";
                
            }else if (self.view.frame.size.width == 414){
                
                sectionName = @"            日期                    請假原因                      審核狀態";
            }
            
            break;
            
        default:
            break;
    }
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaveRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeaveRecordTableViewCell class]) forIndexPath:indexPath];
    
    
    if (self.view.frame.size.width == 320) {
        
        cell.LeaveCellReason.textAlignment = NSTextAlignmentCenter;
        cell.LeaveCellState.textAlignment = NSTextAlignmentCenter; 
        
    }else if (self.view.frame.size.width == 375){
        
        cell.LeaveCellReason.textAlignment = NSTextAlignmentLeft;
        cell.LeaveCellState.textAlignment = NSTextAlignmentLeft;
        
    }else if (self.view.frame.size.width == 414){
        
        cell.LeaveCellReason.textAlignment = NSTextAlignmentLeft;
        cell.LeaveCellState.textAlignment = NSTextAlignmentLeft;
    }

    
    cell.LeaveCellDate.text = [LeaveDateArray objectAtIndex:indexPath.row];
    cell.LeaveCellReason.text = [LeaveNameArray objectAtIndex:indexPath.row];
    cell.LeaveCellState.text = [LeaveStateArray objectAtIndex:indexPath.row];
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaveRecordReload" object:self userInfo:nil];
    
    LeaveDetailViewController *ViewController = [[LeaveDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}



@end
