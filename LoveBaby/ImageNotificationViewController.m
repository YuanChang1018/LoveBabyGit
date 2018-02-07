//
//  ImageNotificationViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/5/4.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ImageNotificationViewController.h"

@interface ImageNotificationViewController ()

@end

@implementation ImageNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NotificationMemory = [NSUserDefaults standardUserDefaults];
    
    NSString *PicURL = [NotificationMemory objectForKey:@"NotificationPic"];
    NSLog(@"PicURL : %@",PicURL);
    NSURL *imageurl = [NSURL URLWithString:PicURL];
    NSData *imagedata = [NSData dataWithContentsOfURL:imageurl];
    self.ImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.ImageView.image = [UIImage imageWithData:imagedata];
    
    NSString *NotifivationString = [NotificationMemory objectForKey:@"NotificationImageBody"];
    self.TextView.text = NotifivationString;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
