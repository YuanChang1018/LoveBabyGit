//
//  LoginViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/7.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    NSUserDefaults *UserMemory;
}

- (IBAction)LoginButton:(id)sender;
- (IBAction)BottomBitton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *BackView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *LoginActivity;
@property (strong, nonatomic) IBOutlet UITextField *AccountText;
@property (strong, nonatomic) IBOutlet UITextField *PasswordText;
@property (strong, nonatomic) IBOutlet UISegmentedControl *IdentitySegmentControl;


- (IBAction)IdentitySegment:(id)sender;
-(void)PostLogin;


@end
