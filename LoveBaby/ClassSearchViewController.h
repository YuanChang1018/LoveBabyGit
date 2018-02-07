//
//  ClassSearchViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/23.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassSearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
 
    NSUserDefaults *ClassMemory;
    
    NSMutableArray *SearchArray;
    NSMutableArray *SearchAnsArray;
    NSMutableArray *SearchTableArray;
    
    NSMutableArray *ClassAnsArray;
    NSMutableArray *TeacherAnsArray;
    NSMutableArray *TimeAnsArray;
    NSMutableArray *PriceAnsArray;
    
    //PickView陣列
    NSMutableArray *CityListArray;
    NSMutableArray *AreaListArray;
    NSMutableArray *BuildingListArray;
    NSMutableArray *ClassListArray;
    NSMutableArray *TeacherListArray;
    NSMutableArray *TimeListArray;
    NSMutableArray *PriceListArray;
    
    
    NSString *SelectedString;
    
    NSString *SelectedClassString;
    NSString *SelectedTeacherString;
    NSString *SelectedTimeString;
    //NSString *SelectedPriceString;
    
}
@property (strong, nonatomic) IBOutlet UITableView *ClassSearchTableView;
- (IBAction)SearchButton:(id)sender;

@end
