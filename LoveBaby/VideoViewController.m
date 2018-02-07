//
//  VideoViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/18.
//  Copyright © 2017年 seae2145. All rights reserved.
//
#import "VideoViewController.h"
#import "VideoTableViewCell.h"

@interface VideoViewController ()

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"影片";
    
    //TableView設定
    [self.VideoTableview registerNib:[UINib nibWithNibName:NSStringFromClass([VideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VideoTableViewCell class])];
    
    VideoIDArray = [[NSMutableArray alloc] init];
    
    
    //Youtube ID
    //去youtube找到該影片 然後從網址後面可以找到Youtube ID
    [VideoIDArray addObject:@"AUjUPh6V1SE"];
    [VideoIDArray addObject:@"ZIcIrvIJyDM"];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [VideoIDArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VideoTableViewCell class]) forIndexPath:indexPath];
    
    [cell.playerView loadWithVideoId:[VideoIDArray objectAtIndex:indexPath.row]];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 150;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
}

@end
