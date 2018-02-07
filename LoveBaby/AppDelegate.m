//
//  AppDelegate.m
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import "AppDelegate.h"
#import "LogViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    
        // iOS 10 or later
    
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
         }
         ];
        
        // For iOS 10 display notification (sent via APNS)
        //[UNUserNotificationCenter currentNotificationCenter].delegate = self;
        // For iOS 10 data message (sent via FCM)

    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    
    
    
    
    
    
    return YES;
}




//前台收到通知
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSLog(@"Notification999 : %@",notification.request.content.userInfo);
    NSLog(@"Notification title : %@",notification.request.content.title);
    

    completionHandler(UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionBadge);
}



//點擊顯示通知
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    
    NotificationMemory = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"response : %@",response.notification.request.content.userInfo);
    NSLog(@"body : %@",response.notification.request.content.body);
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSString *mediaURL = userInfo[@"mediaUrl"];
    NSString *mediaType = userInfo[@"mediaType"];
    
    NSLog(@"response image : %@",mediaURL);
    
    if ([mediaType isEqualToString:@"image"]) {
        
        [NotificationMemory setObject:response.notification.request.content.body forKey:@"NotificationImageBody"];
        [NotificationMemory setObject:mediaURL forKey:@"NotificationPic"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageNotification" object:self userInfo:nil];
        
    }else if ([mediaType isEqualToString:@"web"]){
        
        [NotificationMemory setObject:response.notification.request.content.body forKey:@"NotificationWebBody"];
        [NotificationMemory setObject:mediaURL forKey:@"NotificationURL"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WebNotification" object:self userInfo:nil];
        
    }
    
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}






-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    UserMomeryDeviceToken = [NSUserDefaults standardUserDefaults];
    
    NSString *deviceTokenString = [NSString stringWithFormat:@"%@",deviceToken];
    
    //字串替換
    NSString *str = [deviceTokenString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    
    NSLog(@"Token : %@",str);
    
    [UserMomeryDeviceToken setObject:str forKey:@"DeviceToken"];
    
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //清除Badge數量
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
