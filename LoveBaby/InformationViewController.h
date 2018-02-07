//
//  InformationViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/15.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    NSMutableArray *InfoArray;
    NSMutableArray *InfoArray2;
    NSMutableArray *InfoAnswerArray;
    NSMutableArray *InfoAnswerArray2;
    NSUserDefaults *UserInfo;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *UserScrollView;
@property (strong, nonatomic) IBOutlet UITableView *UserTableView;
@property (strong, nonatomic) IBOutlet UIButton *UserImageButton;
- (IBAction)UserImageButton:(id)sender;

@end
