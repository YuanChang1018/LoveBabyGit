//
//  LeaveViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *LeaveQuesArray;
    NSMutableArray *leaveAnsArray;
    NSMutableArray *LeaveTypeArray;
    NSMutableArray *ChildNameArray;
    
    NSString *SelectedString;
    NSString *StartDate;
    NSString *StartTime;
    NSString *EndDate;
    NSString *EndTime;
}
@property (strong, nonatomic) IBOutlet UIView *BackgroundView;
@property (strong, nonatomic) IBOutlet UITableView *LeaveTableView;
@property (strong,nonatomic) UIAlertController *alert;
@property (strong, nonatomic) IBOutlet UIView *DateView;
@property (strong, nonatomic) IBOutlet UIButton *DateFinishButton;
@property (strong, nonatomic) IBOutlet UIDatePicker *DatePickerView;
- (IBAction)DateFinishButton:(id)sender;
- (IBAction)LeaveButton:(id)sender;

@end
