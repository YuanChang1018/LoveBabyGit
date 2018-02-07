//
//  NamedDetailTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/20.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamedDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *CellIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellNamedLabel;
@property (strong, nonatomic) IBOutlet UISwitch *NamedSwitch;

@end
