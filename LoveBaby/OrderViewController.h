//
//  OrderViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSUserDefaults *UserMemory;
    NSMutableArray *OrderDateArray;
    NSMutableArray *OrderNameArray;
    NSMutableArray *OrderStateArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *OrderTableView;

@end
