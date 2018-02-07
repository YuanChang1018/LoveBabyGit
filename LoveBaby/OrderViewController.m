//
//  OrderViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//
#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "OrderSearchViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"訂單記錄";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"查詢" style:UIBarButtonItemStylePlain target:self action:@selector(OrderSearch:)];
    Buttonitem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"OrderReload" object:nil];
    
    

}



-(IBAction)OrderSearch:(id)sender{
    
    OrderSearchViewController *ViewController = [[OrderSearchViewController alloc] init];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
    
}


//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.OrderTableView reloadData];
    NSLog(@"OrderReload");

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UserMemory = [NSUserDefaults standardUserDefaults];
    
    //TableView設定
    [self.OrderTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderTableViewCell class])];
    
    OrderDateArray = [[NSMutableArray alloc] init];
    OrderNameArray = [[NSMutableArray alloc] init];
    OrderStateArray = [[NSMutableArray alloc] init];
    
    
    
    [OrderDateArray addObject:@"2017/03/12"];
    [OrderDateArray addObject:@"2017/04/06"];
    [OrderDateArray addObject:@"2017/06/15"];
    
    [OrderNameArray addObject:@"奶嘴"];
    [OrderNameArray addObject:@"尿布"];
    [OrderNameArray addObject:@"馬桶"];
    
    [OrderStateArray addObject:@"完成"];
    [OrderStateArray addObject:@"完成"];
    [OrderStateArray addObject:@"完成"];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [OrderNameArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            
            if ([UserMemory floatForKey:@"ViewSize"] == 320) {
                
                sectionName = @"               日期               商品名      訂單狀態";
                
            }else if ([UserMemory floatForKey:@"ViewSize"] == 375){
                
                sectionName = @"              日期                 商品名                   訂單狀態";
                
            }else if ([UserMemory floatForKey:@"ViewSize"] == 414){
                
                sectionName = @"            日期                    商品名                       訂單狀態";
                
            }
            
            break;
            
        default:
            break;
    }
    
    return sectionName;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderTableViewCell class]) forIndexPath:indexPath];
    
    if (self.view.frame.size.width == 320) {
        
        cell.cellTimeLabel.textAlignment = NSTextAlignmentCenter;
        cell.cellNameLabel.textAlignment = NSTextAlignmentCenter;
        
    }else if (self.view.frame.size.width == 375){
        
        cell.cellNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.CellStateLabel.textAlignment = NSTextAlignmentLeft;
        
    }else if (self.view.frame.size.width == 414){
        
        cell.cellNameLabel.textAlignment = NSTextAlignmentLeft;
        cell.CellStateLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    cell.cellTimeLabel.text = [OrderDateArray objectAtIndex:indexPath.row];
    cell.cellNameLabel.text = [OrderNameArray objectAtIndex:indexPath.row];
    cell.CellStateLabel.text = [OrderStateArray objectAtIndex:indexPath.row];
    
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderReload" object:self userInfo:nil];
    
    OrderDetailViewController *ViewController = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}


@end
