       //
//  ClassSearchViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/23.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ClassSearchViewController.h"
#import "ClassSearchTableViewCell.h"
#import "ClassResultViewController.h"
#import "MMPickerView.h"
//#define SeverApiURL @"http://163.13.128.77:8080/jy7/LoginInfoCheck.php"

@interface ClassSearchViewController ()

@end

@implementation ClassSearchViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"課程查詢";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"ClassReload" object:nil];
    
    
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    
    [self.ClassSearchTableView reloadData];
    NSLog(@"ClassReload");
}


- (void)viewDidLoad {
   [super viewDidLoad];
    [self.ClassSearchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ClassSearchTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ClassSearchTableViewCell class])];
   // NSURL *url = [NSURL URLWithString:@"http://163.13.128.77:8080/jy7/LoginInfoCheck.php"];
    //回應Request設定
   // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:20.0];
//    NSString *search = [[NSString alloc]initWithFormat:@"country=%@,city=%@,building=%@",CityListArray,AreaListArray,BuildingListArray];
//    NSData *postData = [search dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = postData;
    
    
    ClassMemory = [NSUserDefaults standardUserDefaults];
    
    SearchArray = [[NSMutableArray alloc] init];
    SearchAnsArray = [[NSMutableArray alloc] init];
    SearchTableArray = [[NSMutableArray alloc]init];
    
    CityListArray = [[NSMutableArray alloc] init];
    AreaListArray = [[NSMutableArray alloc] init];
    BuildingListArray = [[NSMutableArray alloc] init];//
    ClassListArray = [[NSMutableArray alloc] init];
    TeacherListArray = [[NSMutableArray alloc] init];
    TimeListArray = [[NSMutableArray alloc] init];
    PriceListArray = [[NSMutableArray alloc] init];
    
    //搜索標題
    [SearchArray addObject:@"縣市"];
    [SearchArray addObject:@"地區"];
    [SearchArray addObject:@"親子館地點"];
    [SearchArray addObject:@"課程內容"];
    [SearchArray addObject:@"授課老師"];
    [SearchArray addObject:@"上課時段"];
    [SearchArray addObject:@"價格"];
    
   
    
    //[SearchTableArray addObject:SearchArray];
    //[SearchTableArray addObject:@""];
    
    //縣市
    [CityListArray addObject:@"不限"];
    [CityListArray addObject:@"台北市"];
    [CityListArray addObject:@"新北市"];
    [CityListArray addObject:@"桃園市"];
    [CityListArray addObject:@"新竹市"];
    [CityListArray addObject:@"台中市"];
    [CityListArray addObject:@"嘉義市"];
    [CityListArray addObject:@"台南市"];
    [CityListArray addObject:@"高雄市"];
    [CityListArray addObject:@"屏東市"];
    [CityListArray addObject:@"花蓮市"];
    [CityListArray addObject:@"台東市"];
    [CityListArray addObject:@"宜蘭市"];
    
    
    //地區

   
    [AreaListArray addObject:@"不限"];
    [AreaListArray addObject:@"淡水區"];
    [AreaListArray addObject:@"三重區"];
    [AreaListArray addObject:@"新莊區"];
    [AreaListArray addObject:@"內湖區"];
    
   
    
    
    //親子館 資料庫
    //[BuildingListArray addObject:@"不限"];
    
    
    //課程內容 資料庫
    [ClassListArray addObject:@"不限"];
    [ClassListArray addObject:@"土風舞"];
    [ClassListArray addObject:@"雷舞"];
    [ClassListArray addObject:@"芭蕾舞"];
    [ClassListArray addObject:@"恰恰舞"];
    
    //課程老師 資料庫
    [TeacherListArray addObject:@"不限"];
    [TeacherListArray addObject:@"姜人意"];
    [TeacherListArray addObject:@"賤成"];
    [TeacherListArray addObject:@"何番薯"];
    [TeacherListArray addObject:@"何薇薇"];
    
    //課程日期
    [TimeListArray addObject:@"不限"];
    [TimeListArray addObject:@"星期一"];
    [TimeListArray addObject:@"星期二"];
    [TimeListArray addObject:@"星期三"];
    [TimeListArray addObject:@"星期四"];
    [TimeListArray addObject:@"星期五"];
    [TimeListArray addObject:@"星期六"];
    [TimeListArray addObject:@"星期日"];

    
    //課程價錢
    [PriceListArray addObject:@"不限"];
    [PriceListArray addObject:@"1000"];
    [PriceListArray addObject:@"3000"];
    [PriceListArray addObject:@"5000"];
    [PriceListArray addObject:@"10000"];
    
    [SearchAnsArray addObject:[CityListArray objectAtIndex:0]];
    [SearchAnsArray addObject:[AreaListArray objectAtIndex:0]];
    //[SearchAnsArray addObject:[BuildingListArray objectAtIndex:0]];
    [SearchAnsArray addObject:[ClassListArray objectAtIndex:0]];
    [SearchAnsArray addObject:[TeacherListArray objectAtIndex:0]];
    [SearchAnsArray addObject:[TimeListArray objectAtIndex:0]];
    [SearchAnsArray addObject:[PriceListArray objectAtIndex:0]];
    
    [ClassMemory setObject:[CityListArray objectAtIndex:0] forKey:@"SelectedCity"];
    [ClassMemory setObject:[AreaListArray objectAtIndex:0] forKey:@"SelectedArea"];
    //[ClassMemory setObject:[BuildingListArray objectAtIndex:0] forKey:@"SelectedBuilding"];
    [ClassMemory setObject:[ClassListArray objectAtIndex:0] forKey:@"SelectedClass"];
    [ClassMemory setObject:[TeacherListArray objectAtIndex:0] forKey:@"SelectedTeacher"];
    [ClassMemory setObject:[TimeListArray objectAtIndex:0] forKey:@"SelectedTime"];
    [ClassMemory setObject:[PriceListArray objectAtIndex:0] forKey:@"SelectedPrice"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [SearchArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   ClassSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClassSearchTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:0];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:0];
        
    }else if (indexPath.row == 1) {
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:1];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:1];
        
    }else if (indexPath.row == 2) {
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:2];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:2];
        
    }else if (indexPath.row == 3){
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:3];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:3];
        
    }else if (indexPath.row == 4){
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:4];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:4];
        
    }else if (indexPath.row == 5){
        
        cell.CellLabel1.text = [SearchArray objectAtIndex:5];
        cell.CellLabel2.text = [SearchAnsArray objectAtIndex:5];
        
    }//else if (indexPath.row == 6){
//        cell.CellLabel1.text=[SearchArray objectAtIndex:6];
//        cell.CellLabel1.text=[SearchAnsArray objectAtIndex:6];
//    }
     
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClassReload" object:self userInfo:nil];
    
    
    if (indexPath.row == 0) {
        
        if ([ClassMemory objectForKey:@"SelectedCity"] == nil) {
            
            SelectedString = [CityListArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [ClassMemory objectForKey:@"SelectedCity"];
            
        }
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:CityListArray      //設定PickView和toolbar顏色、字型大小
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
                                    [ClassMemory setObject:selectedString forKey:@"SelectedCity"];
                                    
                                }
         ];
        
        
        
        
    }else if (indexPath.row == 1) {
        
        if ([ClassMemory objectForKey:@"SelectedArea"] == nil) {
            
            SelectedString = [AreaListArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [ClassMemory objectForKey:@"SelectedArea"];
            
        }
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:AreaListArray      //設定PickView和toolbar顏色、字型大小
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
                                    [ClassMemory setObject:selectedString forKey:@"SelectedArea"];
                                    
                                }
         ];
        
        
        
        
        
        
    }else if (indexPath.row == 2) {
        
        if ([ClassMemory objectForKey:@"SelectedBuilding"] == nil) {
            
            SelectedString = [BuildingListArray objectAtIndex:0];
        
        }else{
        
            SelectedString = [ClassMemory objectForKey:@"SelectedBuilding"];
        
        }
        
        
            //呼叫PickView
            [MMPickerView showPickerViewInView:self.view
                           withStrings:BuildingListArray      //設定PickView和toolbar顏色、字型大小
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
                                [ClassMemory setObject:selectedString forKey:@"SelectedBuilding"];
                                
                            }
            ];
        
        
        
        
        
    
    }else if (indexPath.row == 3){
        
        
        
        
        if ([ClassMemory objectForKey:@"SelectedClass"] == nil) {
            
            SelectedString = [ClassListArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [ClassMemory objectForKey:@"SelectedClass"];
            
        }

        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:ClassListArray      //設定PickView和toolbar顏色、字型大小
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
                                    [ClassMemory setObject:selectedString forKey:@"SelectedClass"];
                                    
                                   
                                }
         ];

        
        
        
        
        
        
        
    }else if (indexPath.row == 4){
        
        
        
        
        if ([ClassMemory objectForKey:@"SelectedTeacher"] == nil) {
            
            SelectedString = [TeacherListArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [ClassMemory objectForKey:@"SelectedTeacher"];
            
        }
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:TeacherListArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:4 withObject:selectedString];
                                    [ClassMemory setObject:selectedString forKey:@"SelectedTeacher"];
                                }
         ];
        
        
        
        
        
        
        
        
    }else if (indexPath.row == 5){
        
        if ([ClassMemory objectForKey:@"SelectedTime"] == nil) {
            
            SelectedString = [TimeListArray objectAtIndex:0];
            
        }else{
            
            SelectedString = [ClassMemory objectForKey:@"SelectedTime"];
            
        }
        
        
        //呼叫PickView
        [MMPickerView showPickerViewInView:self.view
                               withStrings:TimeListArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:5 withObject:selectedString];
                                    [ClassMemory setObject:selectedString forKey:@"SelectedTime"];
                                    
                                }
         ];
        
        
        
    }else if(indexPath.row==6){
        if([ClassMemory objectForKey:@"SelectedPrice"]==nil){
            SelectedString = [PriceListArray objectAtIndex:0];
        }else{
            SelectedString = [ClassMemory objectForKey:@"SelectedPrice"];
        }
        
        [MMPickerView showPickerViewInView:self.view
                               withStrings:PriceListArray      //設定PickView和toolbar顏色、字型大小
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:SelectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    
                                    [SearchAnsArray replaceObjectAtIndex:6 withObject:selectedString];
                                    [ClassMemory setObject:selectedString forKey:@"SelectedPrice"];
                                    
                                }
         ];
    }



    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔

    if (self.view.frame.size.width == 320) {
        
        return 60;
    
    }else{
    
        return 80;
    }
}


//搜索按鈕 動作
- (IBAction)SearchButton:(id)sender {
    
    
    NSLog(@"縣市：%@",[ClassMemory objectForKey:@"SelectedCity"]);
    NSLog(@"地區：%@",[ClassMemory objectForKey:@"SelectedArea"]);
    NSLog(@"親子館：%@",[ClassMemory objectForKey:@"SelectedBuil"]);
    NSLog(@"課程：%@",[ClassMemory objectForKey:@"SelectedClass"]);
    NSLog(@"老師：%@",[ClassMemory objectForKey:@"SelectedTeacher"]);
    NSLog(@"時間：%@",[ClassMemory objectForKey:@"SelectedTime"]);
    NSLog(@"價錢：%@",[ClassMemory objectForKey:@"SelectedPrice"]);
    
    
    ClassResultViewController *ViewController = [[ClassResultViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
}
@end
