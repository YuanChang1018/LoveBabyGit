//
//  MatterTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatterTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *matterLabel;
@property (strong, nonatomic) IBOutlet UIImageView *matterImage;
@property (nonatomic,assign)CGRect cellFrame;
@end
