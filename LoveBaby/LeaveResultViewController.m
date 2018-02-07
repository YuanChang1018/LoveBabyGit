//
//  LeaveResultViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/30.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LeaveResultViewController.h"
#import "LeaveResultTableViewCell.h"
#import "LeaveDetailViewController.h"

@interface LeaveResultViewController ()

@end

@implementation LeaveResultViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"搜尋結果";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"LeaveResultReload" object:nil];
    
    
}


//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.LeaveRecordTableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.LeaveRecordTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LeaveResultTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LeaveResultTableViewCell class])];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
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
    
    LeaveResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LeaveResultTableViewCell class]) forIndexPath:indexPath];
    
    
    
    if (self.view.frame.size.width == 320) {
        
        cell.CellResultNameLabel.textAlignment = NSTextAlignmentCenter;
        cell.CellResultStateLabel.textAlignment = NSTextAlignmentCenter;
        
    }else if (self.view.frame.size.width == 375){
        
        cell.CellResultNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.CellResultStateLabel.textAlignment = NSTextAlignmentLeft;
        
    }else if (self.view.frame.size.width == 414){
        
        cell.CellResultNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.CellResultStateLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    
    cell.CellResultTimeLabel.text = @"2017-06-22";
    cell.CellResultNameLabel.text = @"生病";
    cell.CellResultStateLabel.text = @"通過";

    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LeaveResultReload" object:self userInfo:nil];
    
     LeaveDetailViewController *ViewController = [[LeaveDetailViewController alloc] init];
     [self.navigationController pushViewController:ViewController animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}



@end
