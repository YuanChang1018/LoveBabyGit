//
//  HealthViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/5/2.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthViewController : UIViewController<UIScrollViewDelegate,UIPageViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSUserDefaults *UserMemory;
    NSMutableArray *TemperatureArray;
    NSMutableArray *WeightArray;
    NSMutableArray *HeightArray;
    NSMutableArray *HeadArray;
    NSMutableArray *StateArray;
    NSMutableArray *ImageArray;
    NSMutableArray *AmountArray;
    NSMutableArray *ChildNameArray;
    
    NSMutableArray *DateArray;
   
    
}

@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentView;
@property (strong, nonatomic) IBOutlet UIScrollView *HealthScrollView;


@end
