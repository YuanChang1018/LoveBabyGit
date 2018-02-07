//
//  MatterViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/21.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatterTableViewCell.h"

@interface MatterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    MatterTableViewCell *cell;
    NSMutableArray *FeaturesArray;
    NSMutableArray *FeaturesImageArray;
}

@property (strong, nonatomic) IBOutlet UITableView *MatterTable;
@end
