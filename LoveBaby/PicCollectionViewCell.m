//
//  PicCollectionViewCell.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "PicCollectionViewCell.h"

@implementation PicCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // cell 初始化顏色 background color
    UIView *bgview = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = bgview;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    
    
    // selected backgroud
    UIView *selectedview = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedview;
    self.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
}

@end
