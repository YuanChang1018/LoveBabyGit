//
//  NamedViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSUserDefaults *ClassMemory;
    NSMutableArray *ClassNumberArray;
    NSMutableArray *ClassNameArray;
    NSMutableArray *ClassDayArray;
    NSMutableArray *ClassTimeArray;
    NSMutableArray *ChildNameArray;
}
@property (strong, nonatomic) IBOutlet UITableView *NamedTableView;

@end
