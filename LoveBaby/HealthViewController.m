//
//  HealthViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/5/2.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "HealthViewController.h"
#import "HealthTableViewCell.h"
#import "SCLAlertView.h"

@interface HealthViewController ()

@end

@implementation HealthViewController

-(void)viewWillAppear:(BOOL)animated{
    
    
    CGFloat scrollWidth = self.HealthScrollView.bounds.size.width;
    CGFloat scrollHeight = self.HealthScrollView.bounds.size.height;
    
    if([UserMemory floatForKey:@"ViewSize"] == 414){
        self.HealthScrollView.contentSize = CGSizeMake((scrollWidth * 4 + 30)+(30*4), scrollHeight);
    }else if ([UserMemory floatForKey:@"ViewSize"] == 375){
        self.HealthScrollView.contentSize = CGSizeMake(scrollWidth * 4, scrollHeight);
    }else{
        NSLog(@"high : %f",self.HealthScrollView.bounds.size.height);
        self.HealthScrollView.contentSize = CGSizeMake((scrollWidth) * 4 - 220, scrollHeight-150);
    }
    
    
    ChildNameArray = [[NSMutableArray alloc] init];
    
    //////////通知 選擇小孩身份 假資料
    //依照帳號ID 抓取小孩編號和名字 名字塞進這個陣列
    [ChildNameArray addObject:@"張小法"];
    
    
    
    
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    
    
    if ([ChildNameArray count] == 1) {
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        
    }else if ([ChildNameArray count]==2){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
    }else if ([ChildNameArray count]==3){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
        
    }else if ([ChildNameArray count]==4){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
    }else if ([ChildNameArray count]==5){
        
        [alert addButton:[ChildNameArray objectAtIndex:0] target:self selector:@selector(first) tag:1];
        [alert addButton:[ChildNameArray objectAtIndex:1] target:self selector:@selector(second) tag:2];
        [alert addButton:[ChildNameArray objectAtIndex:3] target:self selector:@selector(third) tag:3];
        [alert addButton:[ChildNameArray objectAtIndex:4] target:self selector:@selector(fourth) tag:4];
        [alert addButton:[ChildNameArray objectAtIndex:5] target:self selector:@selector(fifth) tag:5];
    }
    
    
    [alert showInfo:self title:@"" subTitle:@"選擇小孩身份" closeButtonTitle:nil duration:0.0f];
    
    
    ///////////////////////////////////////////

    
    
}

//小孩身份
- (void)first{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:0]);
    
}

- (void)second{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:1]);
    
}

- (void)third{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:2]);
    
}

- (void)fourth{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:3]);
    
}

- (void)fifth{
    
    NSLog(@"ChildName: %@",[ChildNameArray objectAtIndex:4]);
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    UserMemory = [NSUserDefaults standardUserDefaults];
    
    self.navigationItem.title = @"健康資訊";
    
    StateArray = [[NSMutableArray alloc]init];
    ImageArray = [[NSMutableArray alloc] init];
    TemperatureArray = [[NSMutableArray alloc]init];
    WeightArray = [[NSMutableArray alloc]init];
    HeightArray = [[NSMutableArray alloc]init];
    HeadArray = [[NSMutableArray alloc]init];
    AmountArray = [[NSMutableArray alloc]init];
    
    DateArray = [[NSMutableArray alloc] init];
    
    
    [StateArray addObject:TemperatureArray];
    [StateArray addObject:WeightArray];
    [StateArray addObject:HeightArray];
    [StateArray addObject:HeadArray];
    
    
    
    [self HealthInfo];
    
    
    
    
    for (int i = 0; i<4; i++) {
        
        [self NumberViewCount:i];
    }

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)HealthInfo{
    
    
    //假資料
    //需要依小孩編號抓取資料庫
    
    
    [DateArray addObject:@"2017-03-18"];
    [DateArray addObject:@"2017-04-08"];
    [DateArray addObject:@"2017-04-30"];
    [DateArray addObject:@"2017-06-22"];
    
    //預設圖片 (不用動)
    [ImageArray addObject:@"thermometer"];
    [ImageArray addObject:@"meter"];
    [ImageArray addObject:@"height"];
    [ImageArray addObject:@"ruler"];
    
    //量 (不用動)
    [AmountArray addObject:@"。C"];
    [AmountArray addObject:@"公斤"];
    [AmountArray addObject:@"公分"];
    [AmountArray addObject:@"公分"];
    
    
    //溫度 假資料
    [TemperatureArray addObject:@"36.1"];
    [TemperatureArray addObject:@"36.2"];
    [TemperatureArray addObject:@"36.5"];
    [TemperatureArray addObject:@"36.3"];
    
    //體重 假資料
    [WeightArray addObject:@"30"];
    [WeightArray addObject:@"32.5"];
    [WeightArray addObject:@"31.8"];
    
    //身高 假資料
    [HeightArray addObject:@"124"];
    [HeightArray addObject:@"125"];
    [HeightArray addObject:@"128"];
    
    //頭圍 假資料
    [HeadArray addObject:@"28.5"];
    [HeadArray addObject:@"30"];
    [HeadArray addObject:@"30.5"];
    
    
    
    
    
    [self.TableView reloadData];
    
}



//scrollview搭配segmentview
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.segmentView.selectedSegmentIndex = (NSInteger)(scrollView.contentOffset.x / self.HealthScrollView.frame.size.width + 0.5);
    
}


- (IBAction)changeCurrentPage:(UISegmentedControl *)sender {
    
    NSInteger page = self.segmentView.selectedSegmentIndex;
    
    CGFloat width, height;
    width = self.HealthScrollView.frame.size.width;
    height = self.HealthScrollView.frame.size.height;
    CGRect frame = CGRectMake(width*page, 0, width, height);
    
    [self.HealthScrollView scrollRectToVisible:frame animated:YES];
    
}


-(void)NumberViewCount:(int)Number{
    
    CGFloat scrollWidth = self.HealthScrollView.bounds.size.width;
    CGFloat scrollHeight = self.HealthScrollView.bounds.size.height;
    
    
    if ([UserMemory floatForKey:@"ViewSize"] == 414) {
        
        self.TableView = [[UITableView alloc] initWithFrame:CGRectMake(20 + ((scrollWidth + 40) * Number),20, scrollWidth-10, scrollHeight-40) style:UITableViewStyleGrouped];
        self.TableView.tag = Number;
        
    }else if ([UserMemory floatForKey:@"ViewSize"] == 375){
        
        self.TableView = [[UITableView alloc] initWithFrame:CGRectMake(20 + (scrollWidth * Number),20, scrollWidth-40, scrollHeight-40) style:UITableViewStyleGrouped];
       self.TableView.tag = Number;
        
        
    }else{
        
        self.TableView = [[UITableView alloc] initWithFrame:CGRectMake(20 + ((scrollWidth-55) * Number),20, scrollWidth-100, scrollHeight-40) style:UITableViewStyleGrouped];
        self.TableView.tag = Number;
        
    }
    
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.scrollEnabled = NO;
    self.TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.TableView.allowsSelection = NO;
    
    [self.TableView registerNib:[UINib nibWithNibName:NSStringFromClass([HealthTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HealthTableViewCell class])];

    self.TableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.HealthScrollView addSubview:self.TableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[StateArray objectAtIndex:tableView.tag] count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    
    
    
    HealthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HealthTableViewCell class]) forIndexPath:indexPath];
    
    NSLog(@"Count : %ld",tableView.tag);
    
    
    cell.cellFrame = CGRectMake(10, 0, self.TableView.frame.size.width - 20, 80);
    cell.layer.cornerRadius = 10;
    
    cell.cellImage.image = [UIImage imageNamed:[ImageArray objectAtIndex:tableView.tag]];
    cell.cellState.text = [[StateArray objectAtIndex:tableView.tag] objectAtIndex:indexPath.row];
    cell.cellamount.text = [AmountArray objectAtIndex:tableView.tag];
    cell.cellDate.text = [DateArray objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 90;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}





@end
