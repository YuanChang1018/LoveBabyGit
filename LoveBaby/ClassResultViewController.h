//
//  ClassResultViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/3/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSUserDefaults *ClassDetail;
    NSUserDefaults *ClassMemory;
    NSMutableArray *ClassNameArray;
    NSMutableArray *ClassTeacherArray;
    NSMutableArray *ClassDayArray;
    NSMutableArray *ClassPriceArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *ClassResultTable;

@end
