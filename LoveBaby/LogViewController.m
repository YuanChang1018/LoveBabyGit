//
//  LogViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/30.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "LogViewController.h"
#import "LogTableViewCell.h"
#import "PictureViewController.h"
#import "VideoViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"互動日誌";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    //TableView LogTableViewCell綁定
    [self.LogTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LogTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LogTableViewCell class])];
  
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogTableViewCell class]) forIndexPath:indexPath];
    
    cell.CellImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.CellImageView.clipsToBounds = YES;
    
    if (indexPath.row == 0) {
        
        cell.CellLabel.text = @"相片";
        cell.CellImageView.image = [UIImage imageNamed:@"picture"];
    
    }
    
    if (indexPath.row == 1) {
        
        cell.CellLabel.text = @"影片";
        cell.CellImageView.image = [UIImage imageNamed:@"film"];
        
    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogReload" object:self userInfo:nil];
    
    if (indexPath.row == 0) {
        
        PictureViewController *ViewController = [[PictureViewController alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
        
    }
    
    if (indexPath.row == 1) {
        
        VideoViewController *ViewController = [[VideoViewController alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
        
    }
    
    NSLog(@"%ld",(long)indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

@end
