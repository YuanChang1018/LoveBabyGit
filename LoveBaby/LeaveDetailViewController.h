//
//  LeaveDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/30.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *LeaveQuesArray;
    NSMutableArray *LeaveAnsArray;
}
@property (strong, nonatomic) IBOutlet UITableView *LeaveDetailTableView;

@end
