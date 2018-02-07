//
//  OrderResultViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSUserDefaults *UserMemory;
}

@property (strong, nonatomic) IBOutlet UITableView *OrderResultTableView;
@end
