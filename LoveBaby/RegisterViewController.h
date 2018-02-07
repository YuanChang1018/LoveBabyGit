//
//  RegisterViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/2/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMPickerView.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    UITextField *tempTextField;
    NSLocale *datelocale;
    NSMutableDictionary *data;
    NSString *selectedstring;
    NSMutableArray *sexarray;
    NSMutableArray *jobarray;
    NSMutableArray *countryarray;
    UIPickerView *sexpicker;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *IdentitySegment;

- (IBAction)RegisterButton:(id)sender;

- (IBAction)IdentitySegement:(id)sender;
-(void)PostRegister;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UITextField *sex;
@property (strong, nonatomic) IBOutlet UITextField *NameLabel;
@property (strong, nonatomic) IBOutlet UITextField *AccountLabel;
@property (strong, nonatomic) IBOutlet UITextField *PasswardLabel;
@property (strong, nonatomic) IBOutlet UITextField *PasswardCheckLabel;
@property (strong, nonatomic) IBOutlet UITextField *Job;
@property (strong, nonatomic) IBOutlet UITextField *Country;
@property (strong, nonatomic) IBOutlet UITextField *Idnumber;
@property (strong, nonatomic) IBOutlet UITextField *Birthday;
@property (strong, nonatomic) IBOutlet UITextField *Email;
@property (strong, nonatomic) IBOutlet UITextField *Address;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *MobilePhone;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (strong, nonatomic) IBOutlet UIPickerView *sexpicker;
@end
