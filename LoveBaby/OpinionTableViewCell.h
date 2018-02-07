//
//  OpinionTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/20.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *cellImageView;
@property (strong, nonatomic) IBOutlet UILabel *cellDate;
@property (strong, nonatomic) IBOutlet UILabel *cellPostion;
@property (strong, nonatomic) IBOutlet UILabel *cellName;
@property (strong, nonatomic) IBOutlet UITextView *cellTextView;

@end
