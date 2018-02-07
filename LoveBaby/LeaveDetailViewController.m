//
//  LeaveDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/30.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LeaveDetailViewController.h"
#import "LeaveDetailTableViewCell.h"

@interface LeaveDetailViewController ()

@end

@implementation LeaveDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"假單內容";
    
    //TableView設定
    [self.LeaveDetailTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeaveDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LeaveDetailTableViewCell class])];
    
    LeaveQuesArray = [[NSMutableArray alloc] init];
    LeaveAnsArray = [[NSMutableArray alloc] init];
    
    [LeaveQuesArray addObject:@"假單編號："];
    [LeaveQuesArray addObject:@"開始日期："];
    [LeaveQuesArray addObject:@"開始時間："];
    [LeaveQuesArray addObject:@"結束日期："];
    [LeaveQuesArray addObject:@"結束時間："];
    [LeaveQuesArray addObject:@"天數："];
    [LeaveQuesArray addObject:@"假別："];
    [LeaveQuesArray addObject:@"原因："];
    [LeaveQuesArray addObject:@"審核狀態："];
    
    [LeaveAnsArray addObject:@"13242"];
    [LeaveAnsArray addObject:@"2017-03-12"];
    [LeaveAnsArray addObject:@"09:00"];
    [LeaveAnsArray addObject:@"2017-03-17"];
    [LeaveAnsArray addObject:@"18:00"];
    [LeaveAnsArray addObject:@"5"];
    [LeaveAnsArray addObject:@"事假"];
    [LeaveAnsArray addObject:@"出國"];
    [LeaveAnsArray addObject:@"通過"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [LeaveQuesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeaveDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeaveDetailTableViewCell class]) forIndexPath:indexPath];
    
    cell.CellLeaveQuesLabel.text = [LeaveQuesArray objectAtIndex:indexPath.row];
    cell.CellLeaveAnsLabel.text = [LeaveAnsArray objectAtIndex:indexPath.row];
    
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}

@end
