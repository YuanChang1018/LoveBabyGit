//
//  ChildInfoDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildInfoDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *ChildMemory;
    NSString *ChildSex;

}
@property (strong, nonatomic) IBOutlet UITableView *ChildSexTable;
@property (strong, nonatomic) IBOutlet UITextField *ChildText;
@property (strong, nonatomic) IBOutlet UIView *ChildDateView;
@property (strong, nonatomic) IBOutlet UIDatePicker *ChildDatePickView;
@property (strong, nonatomic) IBOutlet UILabel *ChildLabel;

@end
