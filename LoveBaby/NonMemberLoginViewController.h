//
//  NonMemberLoginViewController.h
//  LoveBaby
//
//  Created by 呂 原彰 on 2018/2/7.
//  Copyright © 2018年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NonMemberLoginViewController : UIViewController
- (IBAction)nonMemberloginbt:(id)sender;
- (IBAction)nonBottomBitton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nonMemberAccount;
@property (weak, nonatomic) IBOutlet UITextField *nonMemberEmail;
@property (weak, nonatomic) IBOutlet UIView *nonMemberBackview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *nonMemberActivity;




@end
