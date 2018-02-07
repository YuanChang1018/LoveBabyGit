//
//  ChildrenViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildrenViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSUserDefaults *ChildMemory;
    NSMutableArray *ChildrenArray;
}
@property (strong, nonatomic) IBOutlet UITableView *ChildrenTableView;


@end
