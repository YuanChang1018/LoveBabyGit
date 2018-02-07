//
//  OrderDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController


-(void)viewDidAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        
        if (self.view.frame.size.width == 320) {
            
            self.CancelOrderButton.frame = CGRectMake(0, 930, 320, 40);
            self.OrderDetailTableView.frame = CGRectMake(0, 0, 320, 1000);
            self.OrderScrollView.contentSize = CGSizeMake(320,1100);
            
        }else if (self.view.frame.size.width == 375){
            
            self.CancelOrderButton.frame = CGRectMake(0, 930, 375, 40);
            self.OrderDetailTableView.frame = CGRectMake(0, 0, 375, 1000);
            self.OrderScrollView.contentSize = CGSizeMake(375,1100);
            
        }else if (self.view.frame.size.width == 414){
            
            self.CancelOrderButton.frame = CGRectMake(0, 930, 414, 40);
            self.OrderDetailTableView.frame = CGRectMake(0, 0, 414, 1000);
            self.OrderScrollView.contentSize = CGSizeMake(414,1100);
            
        }
    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"訂單內容";
    
    //TableView設定
    [self.OrderDetailTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderDetailTableViewCell class])];
    
    QuestionArray = [[NSMutableArray alloc] init];
    AnsArray = [[NSMutableArray alloc] init];
    
    
    [QuestionArray addObject:@"商家編號："];
    [QuestionArray addObject:@"類型："];
    [QuestionArray addObject:@"商品名："];
    [QuestionArray addObject:@"訂單日期："];
    [QuestionArray addObject:@"出貨日期："];
    [QuestionArray addObject:@"付款方式："];
    [QuestionArray addObject:@"送貨方式："];
    [QuestionArray addObject:@"訂單狀態："];
    [QuestionArray addObject:@"出貨狀態："];
    [QuestionArray addObject:@"價格："];
    [QuestionArray addObject:@"數量："];
    [QuestionArray addObject:@"小記："];
    [QuestionArray addObject:@"合計："];
    [QuestionArray addObject:@"說明："];
    
    
    [AnsArray addObject:@"2342344546"];
    [AnsArray addObject:@"幼兒用品"];
    [AnsArray addObject:@"奶嘴"];
    [AnsArray addObject:@"2017-03-12"];
    [AnsArray addObject:@"2017-03-18"];
    [AnsArray addObject:@"貨到付款"];
    [AnsArray addObject:@"711取貨"];
    [AnsArray addObject:@"結帳"];
    [AnsArray addObject:@"已出貨"];
    [AnsArray addObject:@"1000"];
    [AnsArray addObject:@"3"];
    [AnsArray addObject:@"300"];
    [AnsArray addObject:@"300"];
    [AnsArray addObject:@"要白色的"];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [QuestionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailTableViewCell class]) forIndexPath:indexPath];
    
    cell.CellQuesLabel.text = [QuestionArray objectAtIndex:indexPath.row];
    cell.CellAnsLabel.text = [AnsArray objectAtIndex:indexPath.row];
    
    cell.CellAnsLabel.numberOfLines = 0;
    cell.CellAnsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.CellAnsLabel.adjustsFontSizeToFitWidth = YES;

    
    if (indexPath.row == 13) {
        cell.CellAnsLabel.textAlignment = UIViewContentModeRight;
    }
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (indexPath.row == 13) {
        return 120;
    }
    
    return 60;
}


- (IBAction)CancelOrderButton:(id)sender {
    
    NSLog(@"取消訂單");
}
@end
