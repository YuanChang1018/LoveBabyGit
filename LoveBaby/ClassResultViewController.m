//
//  ClassResultViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ClassResultViewController.h"
#import "ClassResultTableViewCell.h"
#import "ClassDetailViewController.h"

@interface ClassResultViewController ()

@end

@implementation ClassResultViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;

    self.navigationItem.title = @"查詢結果";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"ResultReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    
    [self.ClassResultTable reloadData];
    NSLog(@"ResultReload");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ClassDetail = [NSUserDefaults standardUserDefaults];
    [ClassDetail setObject:@"NoHide" forKey:@"button"];
    
    //TableView設定
    [self.ClassResultTable registerNib:[UINib nibWithNibName:NSStringFromClass([ClassResultTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ClassResultTableViewCell class])];
    
    
    ClassMemory = [NSUserDefaults standardUserDefaults];
    
    ClassNameArray = [[NSMutableArray alloc] init];
    ClassTeacherArray = [[NSMutableArray alloc] init];
    ClassDayArray = [[NSMutableArray alloc] init];
    ClassPriceArray = [[NSMutableArray alloc] init];
    
    
    //搜索結果 假資料
    [ClassNameArray addObject:@"舞蹈"];
    [ClassNameArray addObject:@"鋼琴"];
    [ClassNameArray addObject:@"小提琴"];
    [ClassNameArray addObject:@"跆拳道"];
    
    [ClassTeacherArray addObject:@"姜人意"];
    [ClassTeacherArray addObject:@"林小何"];
    [ClassTeacherArray addObject:@"和建為"];
    [ClassTeacherArray addObject:@"張和威"];
    
    [ClassDayArray addObject:@"禮拜一"];
    [ClassDayArray addObject:@"禮拜三"];
    [ClassDayArray addObject:@"禮拜四"];
    [ClassDayArray addObject:@"禮拜四"];
    
    [ClassPriceArray addObject:@"3000"];
    [ClassPriceArray addObject:@"5000"];
    [ClassPriceArray addObject:@"4500"];
    [ClassPriceArray addObject:@"3000"];
    
    
    //上一個ClassSearchViewCotroller選擇的搜索 把這些值拿去資料庫做搜尋 並回傳搜索的結果
    NSLog(@"縣市：%@",[ClassMemory objectForKey:@"SelectedCity"]);
    NSLog(@"地區：%@",[ClassMemory objectForKey:@"SelectedArea"]);
    NSLog(@"課程：%@",[ClassMemory objectForKey:@"SelectedClass"]);
    NSLog(@"教師：%@",[ClassMemory objectForKey:@"SelectedTeacher"]);
    NSLog(@"時間：%@",[ClassMemory objectForKey:@"SelectedTime"]);
    NSLog(@"價錢：%@",[ClassMemory objectForKey:@"SelectedPrice"]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ClassNameArray count];
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            if (self.view.frame.size.width == 320) {
                
                sectionName = @"     課程         教師            日期               時段";
                
            }else if (self.view.frame.size.width == 375){
                
                sectionName = @"     課程                         教師            日期              時段";
                
            }else if (self.view.frame.size.width == 414){
                
                sectionName = @"   課程                                    教師            日期             時段";
            }
            
            break;
            
            
            
        default:
            break;
    }
    
    
    return sectionName;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ClassResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ClassResultTableViewCell class]) forIndexPath:indexPath];

    
    cell.CellClassLabel.text = [ClassNameArray objectAtIndex:indexPath.row];
    cell.CellTeacherLabel.text = [ClassTeacherArray objectAtIndex:indexPath.row];
    cell.CellDayLabell.text = [ClassDayArray objectAtIndex:indexPath.row];
    cell.CellPriceLabel.text = [ClassPriceArray objectAtIndex:indexPath.row];
    
    
    return cell;
}


//點選動作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResultReload" object:self userInfo:nil];
    
    
    NSLog(@"%ld",(long)indexPath.row);
    NSLog(@"點選課程 : %@",[ClassNameArray objectAtIndex:indexPath.row]);
    
    //記錄選擇的課程的ID 以便下個View以這個ID去搜索詳細資訊
    //[ClassMemory setObject:@"" forKey:@""];
    
    
    ClassDetailViewController *ViewController = [[ClassDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}

@end
