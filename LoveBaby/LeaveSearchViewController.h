//
//  LeaveSearchViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/29.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSUserDefaults *LeaveMemory;
    
    NSString *SelectedString;
    NSMutableArray *SearchLeaveQuesArray;
    NSMutableArray *SearchLeaveAnsArray;
    
    NSMutableArray *YearArray;
    NSMutableArray *MonthArray;
    NSMutableArray *DayArray;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *LeaveSearchTableView;
- (IBAction)LeaveSearchButton:(id)sender;

@end
