//
//  ImageNotificationViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/5/4.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageNotificationViewController : UIViewController{
    
    NSUserDefaults *NotificationMemory;
    BOOL shouldHideStatusBar;
    BOOL shouldHideItemBar;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UITextView *TextView;

@end
