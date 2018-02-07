//
//  OwnClassViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *ClassDetail;
    
}
@property (strong, nonatomic) IBOutlet UITableView *OwnClassTableView;

@end
