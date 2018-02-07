//
//  OrderSearchViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *OrderMemory;
    NSMutableArray *SearchQuesArray;
    NSMutableArray *SearchAnsArray;
    NSMutableArray *YearArray;
    NSMutableArray *MonthArray;
    NSMutableArray *DayArray;
    NSMutableArray *TypeArray;
    NSString *SelectedString;
}
@property (strong, nonatomic) IBOutlet UITableView *OrderSearchTableView;
@property (strong, nonatomic) IBOutlet UIButton *OrderSearchButton;
- (IBAction)OrderSearchButton:(id)sender;

@end
