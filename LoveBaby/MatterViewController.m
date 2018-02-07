//
//  MatterViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2016/12/21.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import "MatterViewController.h"
#import "MatterTableViewCell.h"
#import "ForgetPassViewController.h"

@interface MatterViewController ()

@end

@implementation MatterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"會員管理";
    
    //監聽廣播端 為了更新按鈕
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"MemberReload" object:nil];
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    //[self viewDidLoad];
    [self.MatterTable reloadData];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1];
    
    FeaturesArray = [[NSMutableArray alloc] init];
    [FeaturesArray addObject:@"個人資料"];
    [FeaturesArray addObject:@"更新密碼"];
    
    
    FeaturesImageArray = [[NSMutableArray alloc]init];
    [FeaturesImageArray addObject:@"information"];
    [FeaturesImageArray addObject:@"locked"];
    
    
    [self.MatterTable registerNib:[UINib nibWithNibName:NSStringFromClass([MatterTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MatterTableViewCell class])];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [FeaturesArray count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MatterTableViewCell class]) forIndexPath:indexPath];
    
    [self.MatterTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    cell.cellFrame = CGRectMake(10, 0, self.MatterTable.frame.size.width - 20, 90);
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.matterImage.image = [UIImage imageNamed:[FeaturesImageArray objectAtIndex:indexPath.row]];
    cell.matterLabel.text = [FeaturesArray objectAtIndex:indexPath.row];
    cell.matterLabel.textColor = [UIColor blackColor];
    cell.layer.cornerRadius = 10;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        //個人資料
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"information"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

    }else if (indexPath.row == 1){
        
        //忘記密碼
        ForgetPassViewController *ViewController = [[ForgetPassViewController alloc] init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
        
    }else if (indexPath.row == 2){
        
        
    }
    
    //發出廣播端 為了更新按鈕
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MemberReload" object:self userInfo:nil];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


@end
