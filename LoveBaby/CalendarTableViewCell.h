//
//  CalendarTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/27.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NoteCellLabel;
@property (nonatomic,assign)CGRect cellFrame;

@end
