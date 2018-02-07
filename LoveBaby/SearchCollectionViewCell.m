//
//  SearchCollectionViewCell.m
//  LoveBaby
//
//  Created by seae2145 on 2017/1/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

    
-(void)awakeFromNib{
    [super awakeFromNib];
    
    // background color
    UIView *bgview = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = bgview;
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    
    
    // selected backgroud
    UIView *selectedview = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedview;
    //self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"purple"]];
    self.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
}

@end
