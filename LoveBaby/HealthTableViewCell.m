//
//  HealthTableViewCell.m
//  LoveBaby
//
//  Created by seae2145 on 2017/5/2.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "HealthTableViewCell.h"

@implementation HealthTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect cellRect = self.bounds;
    cellRect.size.width = self.cellFrame.size.width;
    cellRect.size.height = self.cellFrame.size.height;
    
    self.bounds = cellRect;
}
@end
