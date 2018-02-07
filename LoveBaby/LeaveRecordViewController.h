//
//  LeaveRecordViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/28.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveRecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *LeaveDateArray;
    NSMutableArray *LeaveNameArray;
    NSMutableArray *LeaveStateArray;
}
@property (strong, nonatomic) IBOutlet UITableView *LeaveRecordTableView;

@end
