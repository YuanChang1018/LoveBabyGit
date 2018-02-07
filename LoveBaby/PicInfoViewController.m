//
//  PicInfoViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/18.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "PicInfoViewController.h"
#import "PicDetailViewController.h"
#import "PicInfoTableViewCell.h"

@interface PicInfoViewController ()

@end

@implementation PicInfoViewController

-(void)viewDidAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        if (self.view.frame.size.width == 320) {
            
            self.PicInfoImageView.frame = CGRectMake(0, 10, 320, 203);
            self.PicInfoTableView.frame = CGRectMake(0, 210, 320, 600);
            self.PicInfoSrcollView.contentSize = CGSizeMake(320,600);
            
        }else if (self.view.frame.size.width == 375){
            
            self.PicInfoImageView.frame = CGRectMake(0, 10, 375, 203);
            self.PicInfoTableView.frame = CGRectMake(0, 210, 375, 600);
            self.PicInfoSrcollView.contentSize = CGSizeMake(375,800);
            
        }else if (self.view.frame.size.width == 414){
            
            self.PicInfoImageView.frame = CGRectMake(0, 10, 414, 203);
            self.PicInfoTableView.frame = CGRectMake(0, 210, 414, 600);
            self.PicInfoSrcollView.contentSize = CGSizeMake(414,800);
        }
    });
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"PicInfoReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.PicInfoTableView reloadData];
    NSLog(@"AddPicReload");
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.PicInfoTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PicInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([PicInfoTableViewCell class])];
    
    
    
    PicMemory = [NSUserDefaults standardUserDefaults];
    PicURL = [PicMemory objectForKey:@"PicURL"];
    
    self.PicInfoImageView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.PicInfoImageView.imageView.clipsToBounds = YES;
    
    NSURL *imageurl = [NSURL URLWithString:PicURL];
    NSData *imagedata = [NSData dataWithContentsOfURL:imageurl];
    [self.PicInfoImageView setImage:[UIImage imageWithData:imagedata] forState:UIControlStateNormal];
    
    
    
    
    
    
    
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
    
    PicInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PicInfoTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        
        cell.cellQuesLabel.text = @"時間：";
        
        //假資料 改成抓取資料庫
        cell.cellAnsLabel.text = @"2017-02-03";
        
        
    }else if (indexPath.row == 1){
        
        
        cell.cellQuesLabel.text = @"活動：";
        
        //假資料
        cell.cellAnsLabel.text = @"跟家人去吃海鮮大餐！";
    
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (indexPath.row == 1) {
        return 120;
    }
    
    return 60;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PicInfoImageClick:(id)sender {
    
    PicDetailViewController *ViewController = [[PicDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];

    
}
@end
