//
//  UserDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *UserInfo;
    NSString *Sex;
}
@property (strong, nonatomic) IBOutlet UILabel *BirthdayLabel;
@property (strong, nonatomic) IBOutlet UITextField *UserTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *DatePickView;
@property (strong, nonatomic) IBOutlet UIView *DateView;
@property (strong, nonatomic) IBOutlet UITableView *SexTable;


- (IBAction)UserFinish:(id)sender;

@end
