//
//  NamedDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/9.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "NamedDetailViewController.h"
#import "NamedDetailTableViewCell.h"
@protocol SwitchDelegate
- (void)valueChangeNotify:(id)sender;
@end

@interface NamedDetailViewController (){
    
    id<SwitchDelegate> delegate;
    
}


@end

@implementation NamedDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"上課點名";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(NamedFinish:)];
    
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //TableView設定
    [self.NamedTableView registerNib:[UINib nibWithNibName:NSStringFromClass([NamedDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([NamedDetailTableViewCell class])];
    
    ClassMemory = [NSUserDefaults standardUserDefaults];
    
    StudentIDArray = [[NSMutableArray alloc] init];
    StudentNameArray = [[NSMutableArray alloc] init];
    NamedArray = [[NSMutableArray alloc] init];
    
    
    //搜索資料庫
    [self NamedDetail];
    
    
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [StudentIDArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName;
    switch (section) {
            
        case 0:
            if (self.view.frame.size.width == 320) {
                
                sectionName = @"課程                日期                     時段";
                
            }else if (self.view.frame.size.width == 375){
                
                sectionName = [NSString stringWithFormat:@"課程編號：%@                 棒球                 點名",ClassNumber];
                
            }else if (self.view.frame.size.width == 414){
                
                sectionName = @"    課程           日期                     時段";
            }
            
            break;
            
        default:
            break;
    }
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NamedDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NamedDetailTableViewCell class]) forIndexPath:indexPath];
    
    
    cell.NamedSwitch.tag = indexPath.row;
    cell.CellIDLabel.text = [StudentIDArray objectAtIndex:indexPath.row];
    cell.CellNamedLabel.text = [StudentNameArray objectAtIndex:indexPath.row];
    
    [cell.NamedSwitch addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 60;
}

//Switch動作
- (void)valueChange:(id)sender{
    
    [delegate valueChangeNotify:sender];
    
    NSLog(@"change:%ld",(long)[sender tag]);
    
    if ([sender isOn]) {
        
        [NamedArray replaceObjectAtIndex:[sender tag] withObject:@"on"];
        
    }else{
        
        [NamedArray replaceObjectAtIndex:[sender tag] withObject:@"off"];
        
    }
    

}


//完成 動作
-(IBAction)NamedFinish:(id)sender{
    
    //目前是for迴圈一個一個同學更新 之後可能要再優化 最好是改成一次全部更新
    for (int i = 0; i<[StudentIDArray count]; i++) {
        
        //上傳點名
        [self NamedPost:[StudentIDArray objectAtIndex:i] StudentName:[StudentNameArray objectAtIndex:i] Named:[NamedArray objectAtIndex:i]];
        
        
        
        
    }
    

}


//上傳點名
-(void)NamedPost:(NSString *)StudentID StudentName:(NSString *)StudentName Named:(NSString *)Named{
    
    
    //這邊去做上傳資料庫動作
    NSLog(@"Student ID：%@ , Student Name：%@,Named：%@",StudentID,StudentName,Named);
    
}



//搜索資料庫
-(void)NamedDetail{
    
    //以這課程ID去資料庫 搜索同學清單
    ClassNumber = [ClassMemory objectForKey:@"NamedClassNumber"];
    
    [StudentIDArray addObject:@"6958"];
    [StudentIDArray addObject:@"3423"];
    [StudentIDArray addObject:@"4535"];
    [StudentIDArray addObject:@"6453"];
    [StudentIDArray addObject:@"2451"];
    
    [StudentNameArray addObject:@"張小法"];
    [StudentNameArray addObject:@"陳修誠"];
    [StudentNameArray addObject:@"王大鈞"];
    [StudentNameArray addObject:@"何威城"];
    [StudentNameArray addObject:@"陳伯宜"];
    
    
    
    for (int i=0; i<[StudentIDArray count]; i++) {
        
        [NamedArray addObject:@"off"];
        
    }

    [self.NamedTableView reloadData];
    
}






@end
