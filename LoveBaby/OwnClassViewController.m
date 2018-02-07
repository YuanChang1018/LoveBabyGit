//
//  OwnClassViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OwnClassViewController.h"
#import "OwnClassTableViewCell.h"
#import "ClassDetailViewController.h"

@interface OwnClassViewController ()

@end

@implementation OwnClassViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"已選課程";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"OwnClassReload" object:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.OwnClassTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OwnClassTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OwnClassTableViewCell class])];
    
    ClassDetail = [NSUserDefaults standardUserDefaults];
    
    //搜索資料庫 自己有哪些課程
    [self OwnClass];
    
}


//reload方法
-(void)reload:(NSNotification *)notification{
    
    
    [self.OwnClassTableView reloadData];
    NSLog(@"OwnClassReload");
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
                
                sectionName = @"  課程            教師             日期              時段";
                
            }else if (self.view.frame.size.width == 375){
                
                sectionName = @"     課程         教師             日期                時段";
                
            }else if (self.view.frame.size.width == 414){
                
                sectionName = @"   課程          教師             日期               時段";
            }
            
            break;
            
        default:
            break;
    }
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OwnClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OwnClassTableViewCell class]) forIndexPath:indexPath];
    
    if (self.view.frame.size.width == 320) {
        cell.CellClassNameLable.textAlignment = NSTextAlignmentLeft;
    }else{
        cell.CellClassNameLable.textAlignment = NSTextAlignmentCenter;
    }
    
    
    
    //假資料 要改
    cell.CellClassNameLable.text = @"土騷舞";
    cell.CellTeacherLabel.text = @"陳賤成";
    cell.CellDayLabel.text = @"星期三";
    cell.CellTimeLabel.text = @"13:00~15:00";
    

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OwnClassReload" object:self userInfo:nil];
    
    [ClassDetail setObject:@"hide" forKey:@"button"];
    
    ClassDetailViewController *ViewController = [[ClassDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
    
    NSLog(@"%ld",(long)indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}


//搜索資料庫 自己有哪些課程
-(void)OwnClass{
    
    
    //搜索完之後更新tableview
    [self.OwnClassTableView reloadData];
    
}


@end
