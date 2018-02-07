//
//  OrderResultViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OrderResultViewController.h"
#import "OrderDetailViewController.h"
#import "OrderResultTableViewCell.h"

@interface OrderResultViewController ()

@end

@implementation OrderResultViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"搜尋結果";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"OrderResultReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.OrderResultTableView reloadData];
    NSLog(@"OrderResultReload");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UserMemory = [NSUserDefaults standardUserDefaults];
    
    //TableView設定
    [self.OrderResultTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderResultTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderResultTableViewCell class])];
    

    
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
    
    OrderResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderResultTableViewCell class]) forIndexPath:indexPath];
    
    
    cell.CellTimeLabel.text = @"2017/06/10";
    cell.CellNameLabel.text = @"尿布";
    cell.CellStateLabel.text = @"完成";
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderResultReload" object:self userInfo:nil];
    
    
    OrderDetailViewController *ViewController = [[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}


@end
