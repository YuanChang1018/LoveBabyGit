//
//  ChildrenViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ChildrenViewController.h"
#import "ChildrenTableViewCell.h"
#import "ChildDetailViewController.h"
#import "SCLAlertView.h"

@interface ChildrenViewController ()

@end

@implementation ChildrenViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"親屬關係";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"ChildReload" object:nil];
    
    
    //讀取親屬關係 假資料
    [self getChildCount];
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.ChildrenTableView reloadData];
    NSLog(@"ChildRELOAD");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ChildMemory = [NSUserDefaults standardUserDefaults];
    
    //TableView ChildrenTableViewCell 綁定
    [self.ChildrenTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChildrenTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChildrenTableViewCell class])];
    
    //增加右上角 button item
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"增加" style:UIBarButtonItemStylePlain target:self action:@selector(itembar:)];
    
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    //親屬關係陣列 小孩的名稱放這裡
    ChildrenArray = [[NSMutableArray alloc] init];
    
    
}

-(IBAction)itembar:(id)sender{
    
    //目前限定只能增加5位小孩
    if ([ChildrenArray count] > 5) {
    
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        alert.shouldDismissOnTapOutside = YES;
        
        //超過五位會跳通知
        [alert showInfo:self title:@"" subTitle:@"親屬綁定限制五人" closeButtonTitle:@"確定" duration:0.0f];
        
    }else{
    
       
        //跳到增加小孩畫面 淨空小孩資訊ChildAdd
        [ChildMemory setObject:@"add" forKey:@"add"];
    
        [ChildMemory setObject:nil forKey:@"ChildAddName"];
        [ChildMemory setObject:nil forKey:@"ChildAddSex"];
        [ChildMemory setObject:nil forKey:@"ChildAddId"];
        [ChildMemory setObject:nil forKey:@"ChildAddDate"];
        [ChildMemory setObject:nil forKey:@"ChildAddText"];

    
        ChildDetailViewController *ViewController = [[ChildDetailViewController alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//按下刪除按鈕要做的動作  需要刪除遠端資料庫資料
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //依照indexPath.row刪除對應的ChildrenArray陣列資訊
    [ChildrenArray removeObjectAtIndex:indexPath.row];
    
    [self.ChildrenTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"刪除";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ChildrenArray count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([ChildrenArray count] == 0) {
        return @"";
    }else{
        return @"親屬關係";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChildrenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChildrenTableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = [ChildrenArray objectAtIndex:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [ChildMemory setObject:nil forKey:@"add"];
    ChildDetailViewController *ViewController = [[ChildDetailViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChildReload" object:self userInfo:nil];
    
    NSLog(@"%ld",(long)indexPath.row);
    
}


//讀取親屬關係 需要抓取遠端資料庫資料
-(void)getChildCount{
    
    //假資料
    [ChildrenArray addObject:@"張小法"];
    [self.ChildrenTableView reloadData];
    
}


@end
