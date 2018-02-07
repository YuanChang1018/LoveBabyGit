//
//  HealthTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/5/2.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;
@property (strong, nonatomic) IBOutlet UILabel *cellDate;
@property (strong, nonatomic) IBOutlet UILabel *cellState;
@property (strong, nonatomic) IBOutlet UILabel *cellamount;
@property (nonatomic,assign)CGRect cellFrame;

@end
