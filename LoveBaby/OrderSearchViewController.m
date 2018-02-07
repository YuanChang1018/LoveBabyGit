//
//  OrderSearchViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/21.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "OrderSearchViewController.h"
#import "OrderSearchTableViewCell.h"
#import "OrderResultViewController.h"
#import "MMPickerView.h"

@interface OrderSearchViewController ()

@end

@implementation OrderSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"訂單查詢";
    
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"OrderSearchReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    
    [self.OrderSearchTableView reloadData];
    NSLog(@"OrderSearchReload");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.OrderSearchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderSearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderSearchTableViewCell class])];
   
    OrderMemory = [NSUserDefaults standardUserDefaults];
    
    SearchQuesArray = [[NSMutableArray alloc] init];
    SearchAnsArray = [[NSMutableArray alloc] init];
    YearArray = [[NSMutableArray alloc] init];
    MonthArray = [[NSMutableArray alloc] init];
    DayArray = [[NSMutableArray alloc] init];
    TypeArray = [[NSMutableArray alloc]init];
    
    //問題陣列
    [SearchQuesArray addObject:@"年："];
    [SearchQuesArray addObject:@"月："];
    [SearchQuesArray addObject:@"日："];
    [SearchQuesArray addObject:@"類型："];
    
    [YearArray addObject:@"無"];
    [YearArray addObject:@"2017"];
    [YearArray addObject:@"2018"];
    [YearArray addObject:@"2019"];
    
    [MonthArray addObject:@"無"];
    [MonthArray addObject:@"1月"];
    [MonthArray addObject:@"2月"];
    [MonthArray addObject:@"3月"];
    [MonthArray addObject:@"4月"];
    [MonthArray addObject:@"5月"];
    [MonthArray addObject:@"6月"];
    [MonthArray addObject:@"7月"];
    [MonthArray addObject:@"8月"];
    [MonthArray addObject:@"9月"];
    [MonthArray addObject:@"10月"];
    [MonthArray addObject:@"11月"];
    [MonthArray addObject:@"12月"];
    
    
    
    [DayArray addObject:@"無"];
    
    
    [TypeArray addObject:@"無"];
    [TypeArray addObject:@"幼兒用品"];
    [TypeArray addObject:@"清潔護理"];
    [TypeArray addObject:@"安全用品"];
    [TypeArray addObject:@"副食品"];
    [TypeArray addObject:@"玩具"];

    
    
    [SearchAnsArray addObject:[YearArray objectAtIndex:0]];
    [SearchAnsArray addObject:[MonthArray objectAtIndex:0]];
    [SearchAnsArray addObject:[DayArray objectAtIndex:0]];
    [SearchAnsArray addObject:[TypeArray objectAtIndex:0]];
    
    [OrderMemory setObject:[YearArray objectAtIndex:0] forKey:@"OrderYear"];
    [OrderMemory setObject:[MonthArray objectAtIndex:0] forKey:@"OrderMonth"];
    [OrderMemory setObject:[DayArray objectAtIndex:0] forKey:@"OrderDay"];
    [OrderMemory setObject:[TypeArray objectAtIndex:0] forKey:@"OrderType"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [SearchQuesArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderSearchTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.CellQuesLabel.text = [SearchQuesArray objectAtIndex:0];
        cell.CellAnsLabel.text = [SearchAnsArray objectAtIndex:0];
        
    }else if (indexPath.row == 1) {
        
        cell.CellQuesLabel.text = [SearchQuesArray objectAtIndex:1];
        cell.CellAnsLabel.text = [SearchAnsArray objectAtIndex:1];
        
        if ([[OrderMemory objectForKey:@"OrderYear"]isEqualToString:@"無"]){
            cell.CellQuesLabel.textColor = [UIColor lightGrayColor];
            cell.CellAnsLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.CellQuesLabel.textColor = [UIColor blackColor];
            cell.CellAnsLabel.textColor = [UIColor blackColor];
        }
        
        
    }else if (indexPath.row == 2) {
        
        cell.CellQuesLabel.text = [SearchQuesArray objectAtIndex:2];
        cell.CellAnsLabel.text = [SearchAnsArray objectAtIndex:2];
        
        if ([[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"無"]){
            cell.CellQuesLabel.textColor = [UIColor lightGrayColor];
            cell.CellAnsLabel.textColor = [UIColor lightGrayColor];
        }else{
            cell.CellQuesLabel.textColor = [UIColor blackColor];
            cell.CellAnsLabel.textColor = [UIColor blackColor];
        }
        
        
        
    }else if (indexPath.row == 3) {
        
        cell.CellQuesLabel.text = [SearchQuesArray objectAtIndex:3];
        cell.CellAnsLabel.text = [SearchAnsArray objectAtIndex:3];
        
    }
    
    
    
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)path
{
    // Determine if row is selectable based on the NSIndexPath.
    
    if (path.row == 1) {
        if ([[OrderMemory objectForKey:@"OrderYear"]isEqualToString:@"無"]) {
            
            return nil;
        
        }else{
            
            return path;
        
        }
        
    }
    
    if (path.row == 2) {
        if ([[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"無"]) {
            
            return nil;
            
        }else{
            
            return path;
            
        }
        
    }
    
    return path;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderSearchReload" object:self userInfo:nil];
    
    
    
    
    if (indexPath.row == 0) {
        
        if ([OrderMemory objectForKey:@"OrderYear"] == nil) {
            
            SelectedString = [YearArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [OrderMemory objectForKey:@"OrderYear"];
            
        }
        
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:YearArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    
                                    [SearchAnsArray replaceObjectAtIndex:0 withObject:selectedString];
                                    [OrderMemory setObject:selectedString forKey:@"OrderYear"];
                                    
                                    NSLog(@"88888888");
                                }
         ];

        
    }
    
    
    if (indexPath.row == 1) {
        
        
       

        
        if ([OrderMemory objectForKey:@"OrderMonth"] == nil) {
            
            SelectedString = [MonthArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [OrderMemory objectForKey:@"OrderMonth"];
            
        }

        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:MonthArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:1 withObject:selectedString];
                                    [OrderMemory setObject:selectedString forKey:@"OrderMonth"];
                                    
                                    DayArray = [[NSMutableArray alloc] init];
                                    [DayArray addObject:@"無"];
                                    
                                    if ([[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"2月"]) {
                                        NSString *day;
                                        for (int i =1 ; i<29; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                    }else if ([[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"1月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"3月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"2月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"5月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"7月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"8月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"10月"]||[[OrderMemory objectForKey:@"OrderMonth"]isEqualToString:@"12月"]){
                                        
                                        NSString *day;
                                        for (int i =1 ; i<32; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                    }else{
                                        
                                        NSString *day;
                                        for (int i =1 ; i<31; i++) {
                                            
                                            day = [NSString stringWithFormat:@"%d號",i];
                                            [DayArray addObject:day];
                                            
                                        }
                                        
                                    }

                                    
                                }
         ];
        
        
    }

    
    
    if (indexPath.row == 2) {
        
     
        
        if ([OrderMemory objectForKey:@"OrderDay"] == nil) {
            
            SelectedString = [DayArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [OrderMemory objectForKey:@"OrderDay"];
            
        }

        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:DayArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:2 withObject:selectedString];
                                    [OrderMemory setObject:selectedString forKey:@"OrderDay"];
                                    
                                }
         ];
        
        
    }
    
    if (indexPath.row == 3) {
        
        
        
        if ([OrderMemory objectForKey:@"OrderType"] == nil) {
            
            SelectedString = [TypeArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [OrderMemory objectForKey:@"OrderType"];
            
        }
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:TypeArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:3 withObject:selectedString];
                                    [OrderMemory setObject:selectedString forKey:@"OrderType"];
                                    
                                }
         ];
        
        
    }

    
    
    NSLog(@"%ld",(long)indexPath.row);
    
   
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (self.view.frame.size.width == 320) {
        
        return 60;
        
    }else{
        
        return 80;
    }
}


- (IBAction)OrderSearchButton:(id)sender {
    
    NSLog(@"年：%@",[OrderMemory objectForKey:@"OrderYear"]);
    NSLog(@"月：%@",[OrderMemory objectForKey:@"OrderMonth"]);
    NSLog(@"日：%@",[OrderMemory objectForKey:@"OrderDay"]);
    NSLog(@"類型：%@",[OrderMemory objectForKey:@"OrderType"]);
    
    
    
    
    
    OrderResultViewController *ViewController = [[OrderResultViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
}
@end
