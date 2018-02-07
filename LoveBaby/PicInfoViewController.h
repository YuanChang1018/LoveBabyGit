//
//  PicInfoViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/18.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *PicMemory;
    NSString *PicURL;
}
@property (strong, nonatomic) IBOutlet UIScrollView *PicInfoSrcollView;
@property (strong, nonatomic) IBOutlet UIView *PicInfoView;
@property (strong, nonatomic) IBOutlet UIButton *PicInfoImageView;
@property (strong, nonatomic) IBOutlet UITableView *PicInfoTableView;
- (IBAction)PicInfoImageClick:(id)sender;

@end
