//
//  WebNotificationViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/5/4.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebNotificationViewController : UIViewController{
    
    NSUserDefaults *NotificationMemory;
    
}
@property (strong, nonatomic) IBOutlet UIWebView *WebView;

@end
