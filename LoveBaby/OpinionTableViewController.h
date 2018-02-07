//
//  OpinionTableViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/20.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSString *ImageURLString;
    NSMutableArray *UserImageArray;
    NSMutableArray *UserNameArray;
    NSMutableArray *UserDateArray;
    NSMutableArray *UserPositionArray;
    NSMutableArray *UserTextArray;
    
}


@end
