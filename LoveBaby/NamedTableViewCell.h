//
//  NamedTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NamedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *CellClassNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellDayLabel;
@property (strong, nonatomic) IBOutlet UILabel *CellTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *NamedButton;
- (IBAction)NamedButton:(id)sender;

@end
