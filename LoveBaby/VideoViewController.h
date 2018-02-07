//
//  VideoViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/18.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *VideoIDArray;
}
@property (strong, nonatomic) IBOutlet UITableView *VideoTableview;

@end
