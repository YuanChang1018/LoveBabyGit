//
//  ForgetPassViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/22.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPassViewController : UIViewController{
    
    NSString *OldPassword;
    NSString *NewPassword;
    NSString *VerificationPassword;
    
}
@property (strong, nonatomic) IBOutlet UITextField *OldPassText;
@property (strong, nonatomic) IBOutlet UITextField *NewPassText;
@property (strong, nonatomic) IBOutlet UITextField *verificationText;
- (IBAction)SendButton:(id)sender;

@end
