//
//  ChildDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSUserDefaults *ChildMemory;
    NSMutableArray *ChildInfoArray;
    NSMutableArray *ChildAnsArray;
    
}

@property (strong, nonatomic) IBOutlet UITableView *ChildDetailTableView;
@property (strong, nonatomic) IBOutlet UIButton *AddChildButton;
@property (strong, nonatomic) IBOutlet UIButton *ChildImageButton;


- (IBAction)ChildImageButton:(id)sender;
- (IBAction)addChildButton:(id)sender;

@end
