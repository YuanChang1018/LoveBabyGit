//
//  BabyServiceViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyServiceTableViewCell.h"
@interface BabyServiceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *UserMemory;
    BabyServiceTableViewCell *cell;
    NSMutableArray *BabyFeaturesArray;
    NSMutableArray *BabyFeaturesImageArray;
    NSMutableArray *ChildNameArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *BabyServiceTable;

@end
