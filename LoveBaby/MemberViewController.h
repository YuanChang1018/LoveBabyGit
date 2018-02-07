//
//  MemberViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/19.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberViewController : UIViewController{
    
    NSUserDefaults *UserMemory;
    
}
- (IBAction)LogoutButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *MemberImageView;
@property (strong, nonatomic) IBOutlet UILabel *MemberNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *EmailLabel;

@end
