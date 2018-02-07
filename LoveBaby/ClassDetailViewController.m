//
//  ClassDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ClassDetailViewController.h"
#import "ClassDetailTableViewCell.h"

@interface ClassDetailViewController ()

@end

@implementation ClassDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"課程介紹";

    NSLog(@"Screen : %f",self.view.frame.size.width);
    
    
}




-(void)viewDidAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(),^{
    
        
         if (self.view.frame.size.width == 320) {
             
             self.BuyButton.frame = CGRectMake(0, 825, 320, 40);
             self.CancelButton.frame = CGRectMake(0, 825, 320, 40);
             self.ClassDetailTable.frame = CGRectMake(0, 0, 320, 800);
             self.SrcollView.contentSize = CGSizeMake(320,1000);

             
             self.SrcollView.contentSize = CGSizeMake(320,900);
             
         }else if (self.view.frame.size.width == 375){
             
             self.SrcollView.contentSize = CGSizeMake(375,900);
             self.BuyButton.frame = CGRectMake(0, 825, 375, 40);
             self.CancelButton.frame = CGRectMake(0, 825, 375, 40);
             
         }else if (self.view.frame.size.width == 414){
         
             self.BuyButton.frame = CGRectMake(0, 825, 414, 40);
             self.CancelButton.frame = CGRectMake(0, 825, 414, 40);
             self.ClassDetailTable.frame = CGRectMake(0, 0, 414, 800);
             self.SrcollView.contentSize = CGSizeMake(414,900);
             
             
         }
         
        
    });
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //這個view是"搜索課程結果"的詳細資料跟"課程紀錄"的詳細資料是共用的
    
    
    ClassDetail = [NSUserDefaults standardUserDefaults];
    
    //view是"搜索課程結果"
    if ([[ClassDetail objectForKey:@"button"]isEqualToString:@"hide"]) {
        
        self.BuyButton.hidden = YES;
        self.CancelButton.hidden = NO;
        
    //view是"課程紀錄"
    }else{
        
        self.BuyButton.hidden = NO;
        self.CancelButton.hidden = YES;
    }
    
    
    //TableView設定
    [self.ClassDetailTable registerNib:[UINib nibWithNibName:NSStringFromClass([ClassDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ClassDetailTableViewCell class])];
    
    self.ClassDetailTable.rowHeight = UITableViewAutomaticDimension;
    
    ClassQuestionArray = [[NSMutableArray alloc] init];
    ClassAnsArray = [[NSMutableArray alloc] init];
    
    
    //詳細資訊欄位
    [ClassQuestionArray addObject:@"課程編號："];
    [ClassQuestionArray addObject:@"課程名稱："];
    [ClassQuestionArray addObject:@"授課老師："];
    [ClassQuestionArray addObject:@"上課日期："];
    [ClassQuestionArray addObject:@"上課時段："];
    [ClassQuestionArray addObject:@"老師簡介："];
    [ClassQuestionArray addObject:@"課程內容："];
    [ClassQuestionArray addObject:@"教室編號："];
    [ClassQuestionArray addObject:@"全部名額："];
    [ClassQuestionArray addObject:@"保留名額："];
    [ClassQuestionArray addObject:@"剩餘名額："];
    [ClassQuestionArray addObject:@"價格："];
    
    
    //以上一個View存的課程ID 搜索詳細資料顯示出來
    //假資料
    [ClassAnsArray addObject:@"34954"];
    [ClassAnsArray addObject:@"舞蹈"];
    [ClassAnsArray addObject:@"姜人意"];
    [ClassAnsArray addObject:@"禮拜三"];
    [ClassAnsArray addObject:@"13:00~15:00"];
    [ClassAnsArray addObject:@"本課程專注於學員對身體的深層探索，自我身體認知，找到個人的動作特質。融入東、西方精髓的體能與技巧訓練"];
    [ClassAnsArray addObject:@"跳健康的舞蹈"];
    [ClassAnsArray addObject:@"E342"];
    [ClassAnsArray addObject:@"90"];
    [ClassAnsArray addObject:@"10"];
    [ClassAnsArray addObject:@"8"];
    [ClassAnsArray addObject:@"5000"];

    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ClassQuestionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClassDetailTableViewCell class]) forIndexPath:indexPath];
    
    cell.CellQuestionLabel.text = [ClassQuestionArray objectAtIndex:indexPath.row];
    cell.CellAnsLabel.numberOfLines = 0;
    cell.CellAnsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.CellAnsLabel.adjustsFontSizeToFitWidth = YES;
    cell.CellAnsLabel.text = [ClassAnsArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 5) {
        cell.CellAnsLabel.textAlignment = UIViewContentModeRight;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (indexPath.row == 5) {
        return 120;
    }
    
    return 60;
}


//購買課程按鈕
- (IBAction)BuyClassButtun:(id)sender {
    
        NSLog(@"Buy");
    
    
}

//取消按鈕
- (IBAction)CancelButton:(id)sender {

        NSLog(@"Cancel");
}






@end
