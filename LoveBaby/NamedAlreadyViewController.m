//
//  NamedAlreadyViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/9.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "NamedAlreadyViewController.h"
#import "NameAlreadyTableViewCell.h"

@interface NamedAlreadyViewController ()

@end

@implementation NamedAlreadyViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"點名紀錄";
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.NameAlreadyTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NameAlreadyTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NameAlreadyTableViewCell class])];

    StudentNameArray = [[NSMutableArray alloc] init];
    NamedArray = [[NSMutableArray alloc] init];
    
    ClassMemory = [NSUserDefaults standardUserDefaults];
    
    
    
    
    
     //搜索資料庫
     [self ClassAlreadyName];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [StudentNameArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            if (self.view.frame.size.width == 320) {
                
                sectionName = @"課程                日期                     時段";
                
            }else if (self.view.frame.size.width == 375){
                
              
                sectionName = [NSString stringWithFormat:@"    編號：%@                    棒球                      ",ClassNumber];
                
            }else if (self.view.frame.size.width == 414){
                
                sectionName = @"    課程           日期                     時段";
            }
            
            break;
            
        default:
            break;
    }
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NameAlreadyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NameAlreadyTableViewCell class]) forIndexPath:indexPath];
    
   
    cell.CellNameLabel.text = [StudentNameArray objectAtIndex:indexPath.row];
    
    
    //判斷點名 更換圖片
    if ([[NamedArray objectAtIndex:indexPath.row]isEqualToString:@"點名"])  {
        cell.CellImageView.image = [UIImage imageNamed:@"checked"];
    }else{
        cell.CellImageView.image = [UIImage imageNamed:@"uncheck"];
    }
    
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}



//搜索資料庫  抓取對應的課程ID 點名清單
-(void)ClassAlreadyName{
    
    //課程ID 搜索資料庫
    ClassNumber = [ClassMemory objectForKey:@"ClassNumber"];
    NSLog(@"課程編號：%@",ClassNumber);
    
    
    //假資料
    [StudentNameArray addObject:@"張小法"];
    [StudentNameArray addObject:@"陳修誠"];
    [StudentNameArray addObject:@"王大鈞"];
    [StudentNameArray addObject:@"何威城"];
    [StudentNameArray addObject:@"陳伯宜"];
    
    [NamedArray addObject:@"點名"];
    [NamedArray addObject:@"點名"];
    [NamedArray addObject:@"未點"];
    [NamedArray addObject:@"點名"];
    [NamedArray addObject:@"點名"];
    
    
    
    //抓取完課程更新Tableview
    [self.NameAlreadyTableView reloadData];
    
}



@end
