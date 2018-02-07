//
//  BabyServiceTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BabyServiceTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *BabycellImage;
@property (strong, nonatomic) IBOutlet UILabel *BabycellLabel;
@property (nonatomic,assign)CGRect cellFrame;
@end
