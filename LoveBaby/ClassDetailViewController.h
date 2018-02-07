//
//  ClassDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *ClassQuestionArray;
    NSMutableArray *ClassAnsArray;
    NSUserDefaults *ClassDetail;
}
@property (strong, nonatomic) IBOutlet UIButton *CancelButton;
@property (strong, nonatomic) IBOutlet UIButton *BuyButton;
@property (strong, nonatomic) IBOutlet UIScrollView *SrcollView;
@property (strong, nonatomic) IBOutlet UITableView *ClassDetailTable;
- (IBAction)BuyClassButtun:(id)sender;
- (IBAction)CancelButton:(id)sender;

@end
