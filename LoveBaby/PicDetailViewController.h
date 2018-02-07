//
//  PicDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetailViewController : UIViewController{
    NSUserDefaults *PicMemory;
    BOOL shouldHideStatusBar;
    BOOL shouldHideItemBar;
}
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;


@end
