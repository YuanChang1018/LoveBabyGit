//
//  OpinionTableViewCell.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/20.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OpinionTableViewCell.h"

@implementation OpinionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)setFrame:(CGRect)frame{
    
    frame.origin.x += 10;
    frame.origin.y += 10;
    frame.size.height -= 10;
    frame.size.width -= 20;
    [super setFrame:frame];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
