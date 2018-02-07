//
//  AppDelegate.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>{
    NSUserDefaults *UserMomeryDeviceToken;
    NSUserDefaults *NotificationMemory;
}

@property (strong, nonatomic) UIWindow *window;


@end

