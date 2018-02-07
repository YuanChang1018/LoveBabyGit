//
//  OrderTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *cellTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellStateLabel;

@end
