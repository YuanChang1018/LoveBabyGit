//
//  AddPicViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>{
    
    NSUserDefaults *PicMemory;
    NSString *PicDate;
    NSString *PicText;
    UIImage *newImage;
}



@property (strong, nonatomic) IBOutlet UIScrollView *PicScrollView;
@property (strong, nonatomic) IBOutlet UITableView *PicTableview;
@property (strong, nonatomic) IBOutlet UIButton *imageButton;
- (IBAction)imageButton:(id)sender;
@end
