//
//  OwnClassTableViewCell.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OwnClassTableViewCell.h"

@implementation OwnClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _CellTimeLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
