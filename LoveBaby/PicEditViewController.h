//
//  PicEditViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/17.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicEditViewController : UIViewController{
    
    NSUserDefaults *PicMemory;
    
}
@property (strong, nonatomic) IBOutlet UIDatePicker *PicDatePick;

@end
