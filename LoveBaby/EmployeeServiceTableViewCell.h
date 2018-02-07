//
//  EmployeeServiceTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/27.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeServiceTableViewCell : UITableViewCell
@property (nonatomic,assign)CGRect cellFrame;
@property (strong, nonatomic) IBOutlet UIImageView *EmployCellImage;
@property (strong, nonatomic) IBOutlet UILabel *EmployCellLabel;
@end
