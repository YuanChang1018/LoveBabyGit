//
//  OwnClassTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnClassTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *CellClassNameLable;
@property (strong, nonatomic) IBOutlet UILabel *CellTeacherLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellTimeLabel;

@end
