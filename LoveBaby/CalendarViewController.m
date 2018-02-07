//
//  CalendarViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2016/12/26.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarTableViewCell.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    

   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //CalendarTableViewCell.h 宣告綁定
    [self.NoteTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CalendarTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CalendarTableViewCell class])];

    
    self.navigationItem.title = @"行事曆";
    
    //JTCalendarManager API宣告
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
    //JTCalendarManager 設定
    _calendarManager.settings.pageViewHaveWeekDaysView = NO;
    _calendarManager.settings.pageViewNumberOfWeeks = 0; // Automatic
    
    _weekDayView.manager = _calendarManager;
    [_weekDayView reload];
    
    // Generate random events sort by date using a dateformatter for the demonstration
    [self createRandomEvents];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    _calendarMenuView.scrollView.scrollEnabled = NO; // Scroll not supported with JTVerticalCalendarView
    
    //行事曆裡的活動內容
    [self GetNoteText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
//不同類型的背景顏色設定
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    dayView.hidden = NO;
    
    // Hide if from another month
    if([dayView isFromAnotherMonth]){
        dayView.hidden = YES;
    }
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    if([self haveEventForDay:dayView.date]){
        dayView.dotView.hidden = NO;
    }
    else{
        dayView.dotView.hidden = YES;
    }
}


//點選行事曆的反應  點選log會顯示出Date日期
- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    NSLog(@"Date : %@",_dateSelected);
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    
    // Don't change page in week mode because block the selection of days in first and last weeks of the month
    if(_calendarManager.settings.weekModeEnabled){
        return;
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}


//日期的文字顯示
- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UILabel *)menuItemView date:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
    
    if(!dateFormatter){
        
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"MMMM yyyy";
        
        dateFormatter.locale = _calendarManager.dateHelper.calendar.locale;
        dateFormatter.timeZone = _calendarManager.dateHelper.calendar.timeZone;
        
    }
    
    menuItemView.text = [dateFormatter stringFromDate:date];
    menuItemView.font = [menuItemView.font fontWithSize:22];

}



#pragma mark - Fake data

// Used only to have a key for _eventsByDate
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}

- (BOOL)haveEventForDay:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(_eventsByDate[key] && [_eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
    
}


//日期標記  這邊標記 "2017-12-25"  日後要標記什麼日期再添加
- (void)createRandomEvents
{
    
    _eventsByDate = [NSMutableDictionary new];
    
    
    //需要转换的字符串  假資料
    NSString *dateString = @"2017-12-25";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    
    
    NSString *key = [[self dateFormatter] stringFromDate:date];
    if(!_eventsByDate[key]){
        _eventsByDate[key] = [NSMutableArray new];
    }
    
    
    [_eventsByDate[key] addObject:date];
    
    
    
    /*
     for(int i = 0; i < 30; ++i){
     // Generate 30 random dates between now and 60 days later
     NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
     NSString *random  =  [NSString stringWithFormat:@"%@",randomDate];
     NSLog(@"randomDate : %@",random);
     
     // Use the date as key for eventsByDate
     NSString *key = [[self dateFormatter] stringFromDate:randomDate];
     NSLog(@"key:%@",key);
     
     if(!_eventsByDate[key]){
     _eventsByDate[key] = [NSMutableArray new];
     }
     
     [_eventsByDate[key] addObject:randomDate];
     }
     
     */
    
    
}


//下方tableview詳細文字訊息
-(void)GetNoteText{
    
    
    
    NoteArray = [[NSMutableArray alloc]init];
    
    //假資料
    NSMutableArray *Title = [[NSMutableArray alloc] init];
    [Title addObject:@"第50週活動"];
    [Title addObject:@"第51週活動"];
    
    NSMutableArray *NoteDetailArray = [[NSMutableArray alloc] init];
    
    
    
    //假資料
    //第一區段文字
    NSString *sectionName = [Title objectAtIndex:0];
    [NoteDetailArray addObject:sectionName];
    
    NSString *row = @"出去玩";
    [NoteDetailArray addObject:row];
    [NoteArray addObject:NoteDetailArray];
    
    
    
    //假資料
    //第二區段文字
    NoteDetailArray = [[NSMutableArray alloc] init];
    
    sectionName = [Title objectAtIndex:1];
    [NoteDetailArray addObject:sectionName];
    
    row = @"做勞作";
    [NoteDetailArray addObject:row];
    row = @"放假";
    [NoteDetailArray addObject:row];
    
    [NoteArray addObject:NoteDetailArray];
}





#pragma mark TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [NoteArray count];
    //return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[NoteArray objectAtIndex:section] count] - 1;
    //return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [[NoteArray objectAtIndex:section] objectAtIndex:0];
    //NSLog(@"section : %ld",(long)section);
    //return @"999";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CalendarTableViewCell class]) forIndexPath:indexPath];
    
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    cell.cellFrame = CGRectMake(10, 0, self.NoteTableView.frame.size.width - 20, 90);
    cell.NoteCellLabel.text = [[NoteArray objectAtIndex:section]objectAtIndex: row + 1 ];
    cell.NoteCellLabel.adjustsFontSizeToFitWidth = YES;
    cell.backgroundColor = [UIColor whiteColor];
    //cell.layer.shadowColor = [UIColor blackColor].CGColor;
    //cell.layer.shadowRadius = 5;
    //cell.layer.shadowOffset = CGSizeMake(5, 5);
    //cell.layer.shadowOpacity = 0.5;
    cell.layer.cornerRadius = 10;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    return 100;
}









@end
