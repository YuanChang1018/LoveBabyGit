//
//  CalendarViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2016/12/26.
//  Copyright © 2016年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "CalendarTableViewCell.h"

@interface CalendarViewController : UIViewController<JTCalendarDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSMutableDictionary *_eventsByDate;
    NSMutableArray *NoteArray;
    CalendarTableViewCell *cell;
    
    NSDate *_todayDate;
    NSDate *_minDate;
    NSDate *_maxDate;
    NSDate *_dateSelected;
}
@property (strong, nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (strong, nonatomic) IBOutlet JTHorizontalCalendarView *calendarContentView;
@property (strong, nonatomic) IBOutlet JTCalendarWeekDayView *weekDayView;
@property (strong, nonatomic) IBOutlet UITableView *NoteTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@property (strong, nonatomic) JTCalendarManager *calendarManager;

@end
