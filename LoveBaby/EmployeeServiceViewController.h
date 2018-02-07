//
//  EmployeeServiceViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EmployeeServiceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *UserMemory;
    NSMutableArray *EmployeeServiceArray;
    NSMutableArray *EmployeeImageArray;
    NSMutableArray *ChildNameArray;
}
@property (strong, nonatomic) IBOutlet UITableView *EmployeeServiceTableView;

@end
