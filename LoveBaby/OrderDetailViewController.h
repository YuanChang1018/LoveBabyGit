//
//  OrderDetailViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *QuestionArray;
    NSMutableArray *AnsArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *OrderDetailTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *OrderScrollView;
@property (strong, nonatomic) IBOutlet UIButton *CancelOrderButton;
- (IBAction)CancelOrderButton:(id)sender;


@end
