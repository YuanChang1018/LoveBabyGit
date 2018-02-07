//
//  NamedViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "NamedViewController.h"
#import "NamedDetailViewController.h"
#import "NamedAlreadyViewController.h"
#import "NamedTableViewCell.h"
#import "SCLAlertView.h"

@interface NamedViewController ()

@end

@implementation NamedViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"上課點名";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"NamedReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    
    [self.NamedTableView reloadData];
    NSLog(@"NamedReload");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ClassMemory = [NSUserDefaults standardUserDefaults];
    
    ClassNumberArray = [[NSMutableArray alloc] init];
    ClassNameArray = [[NSMutableArray alloc] init];
    ClassDayArray = [[NSMutableArray alloc] init];
    ClassTimeArray = [[NSMutableArray alloc] init];
    
    //TableView NamedTableViewCell綁定
    [self.NamedTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NamedTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NamedTableViewCell class])];
    
    
    
    
    
    
    
    //搜索資料
    [self ClassNamed];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ClassNumberArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            if (self.view.frame.size.width == 320) {
                
                sectionName = @"課程                日期                     時段";
                
            }else if (self.view.frame.size.width == 375){
                
                sectionName = @"      課程          日期                      時段";
                
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
    
    NamedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NamedTableViewCell class]) forIndexPath:indexPath];
    
    if (self.view.frame.size.width == 320) {
        cell.CellClassNameLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        cell.CellClassNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.CellClassNameLabel.text = [ClassNameArray objectAtIndex:indexPath.row];
    cell.CellClassNameLabel.adjustsFontSizeToFitWidth = YES;
    cell.CellDayLabel.text = [ClassDayArray objectAtIndex:indexPath.row];
    cell.CellTimeLabel.text = [ClassTimeArray objectAtIndex:indexPath.row];
    cell.CellTimeLabel.adjustsFontSizeToFitWidth = YES;
    cell.NamedButton.tag = indexPath.row;
    
    
    [cell.NamedButton addTarget:self action:@selector(Named:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}


//點名按鈕
- (void)Named:(id)sender{
    
    
    NSLog(@"點名：%ld",(long)[sender tag]);
    
    
    [ClassMemory setObject:[ClassNumberArray objectAtIndex:[sender tag]] forKey:@"NamedClassNumber"];
    
    NamedDetailViewController *ViewController = [[NamedDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NamedReload" object:self userInfo:nil];
    
    
    [ClassMemory setObject:[ClassNumberArray objectAtIndex:indexPath.row] forKey:@"ClassNumber"];
    NamedAlreadyViewController *ViewController = [[NamedAlreadyViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
    
    NSLog(@"%ld",(long)indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}


//搜索資料庫 抓取自己課程
-(void)ClassNamed{
    
    //這裡要顯示有哪些課程點名 目前假資料
    [ClassNumberArray addObject:@"1364"];
    [ClassNumberArray addObject:@"2338"];
    
    [ClassNameArray addObject:@"棒球"];
    [ClassNameArray addObject:@"籃球"];
    
    [ClassDayArray addObject:@"星期一"];
    [ClassDayArray addObject:@"星期三"];
    
    [ClassTimeArray addObject:@"09:00~12:00"];
    [ClassTimeArray addObject:@"10:00~13:00"];
    
    
    //抓取完課程更新Tableview
    [self.NamedTableView reloadData];
    
}

@end
