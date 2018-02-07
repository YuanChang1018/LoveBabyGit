//
//  VideoTableViewCell.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/18.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@interface VideoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;

@end
