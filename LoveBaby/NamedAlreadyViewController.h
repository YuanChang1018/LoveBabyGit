//
//  NamedAlreadyViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/9.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamedAlreadyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSUserDefaults *ClassMemory;
    NSString *ClassNumber;
    NSMutableArray *StudentNameArray;
    NSMutableArray *NamedArray;
}
@property (strong, nonatomic) IBOutlet UITableView *NameAlreadyTableView;

@end
