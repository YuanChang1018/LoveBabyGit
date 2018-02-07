//
//  OpinionTableViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/20.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OpinionTableViewController.h"
#import "OpinionTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewOpinionViewController.h"

@interface OpinionTableViewController ()

@end

@implementation OpinionTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"意見交流";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(addOpinion:)];
    
    Buttonitem.image = [UIImage imageNamed:@"add"];
    Buttonitem.tintColor = [UIColor colorWithRed:255/255.0f green:221/255.0f blue:51/255.0f alpha:1];
    self.navigationItem.rightBarButtonItem = Buttonitem;
 
    
}

//增加留言按鈕
-(IBAction)addOpinion:(id)sender{
    
    //切到增加留言view
    NewOpinionViewController *ViewController = [[NewOpinionViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TableView設定
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OpinionTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OpinionTableViewCell class])];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //滑動更新
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(handleReresh) forControlEvents:UIControlEventValueChanged];
    
    //抓取圖片 URL
    ImageURLString = @"http://163.13.128.77/Lovebaby/image/";
    
    
    
    UserImageArray = [[NSMutableArray alloc] init];
    UserNameArray = [[NSMutableArray alloc] init];
    UserPositionArray = [[NSMutableArray alloc] init];
    UserDateArray = [[NSMutableArray alloc] init];
    UserTextArray = [[NSMutableArray alloc] init];
    
    
    
    //更新資料
    [self Opinioninfo];
    
    
}

-(void)handleReresh{
    
    //停止下拉動畫
    [self.refreshControl endRefreshing];
    //更新資料
    [self.tableView reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新中..."];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//從遠端資料庫抓取資料
-(void)Opinioninfo{
    

    //假資料
    
    
    //圖片
    [UserImageArray addObject:@"user6"];
    [UserImageArray addObject:@"user1"];
    [UserImageArray addObject:@"user2"];
    [UserImageArray addObject:@"user3"];
    [UserImageArray addObject:@"user4"];
    [UserImageArray addObject:@"user5"];
    
    //名字
    [UserNameArray addObject:@"Henry"];
    [UserNameArray addObject:@"Gary"];
    [UserNameArray addObject:@"Mushroom"];
    [UserNameArray addObject:@"Hewehain"];
    [UserNameArray addObject:@"Jack"];
    [UserNameArray addObject:@"Jordan"];
    
    //職位
    [UserPositionArray addObject:@"教職員工"];
    [UserPositionArray addObject:@"園長"];
    [UserPositionArray addObject:@"家長"];
    [UserPositionArray addObject:@"家長"];
    [UserPositionArray addObject:@"家長"];
    [UserPositionArray addObject:@"教職員工"];
    
    //日期
    [UserDateArray addObject:@"2017-03-12"];
    [UserDateArray addObject:@"2017-03-13"];
    [UserDateArray addObject:@"2017-04-02"];
    [UserDateArray addObject:@"2017-04-08"];
    [UserDateArray addObject:@"2017-04-08"];
    [UserDateArray addObject:@"2017-05-12"];
    
    //內容
    [UserTextArray addObject:@"這系統真好用！"];
    [UserTextArray addObject:@"小孩子都好棒喔！每個小孩都很乖！"];
    [UserTextArray addObject:@"這系統可以促進跟小孩的回憶"];
    [UserTextArray addObject:@"每天都可以確認小孩讓我好放心"];
    [UserTextArray addObject:@"這系統讓我很放心！"];
    [UserTextArray addObject:@"我們每天跟小孩上課都好開心"];

    
    //更新TableView
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [UserImageArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OpinionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OpinionTableViewCell class]) forIndexPath:indexPath];
    
    //大頭照
    NSString *URLString = [NSString stringWithFormat:@"%@%@.jpg",ImageURLString,[UserImageArray objectAtIndex:indexPath.row]];
    
    [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:URLString] placeholderImage:[UIImage imageNamed:@"addpicture"] options:SDWebImageRefreshCached];
    cell.cellDate.adjustsFontSizeToFitWidth = YES;
    cell.cellName.adjustsFontSizeToFitWidth = YES;
    cell.cellPostion.adjustsFontSizeToFitWidth = YES;
    
    
    
    cell.cellDate.text = [UserDateArray objectAtIndex:indexPath.row];
    cell.cellName.text = [UserNameArray objectAtIndex:indexPath.row];
    cell.cellPostion.text = [UserPositionArray objectAtIndex:indexPath.row];
    cell.cellTextView.text = [UserTextArray objectAtIndex:indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 110;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}








@end
