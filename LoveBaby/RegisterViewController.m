//
//  RegisterViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/8.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end



@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



- (IBAction)BottomButton:(id)sender {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
 
}

- (IBAction)IdentitySegement:(id)sender {
    
    switch (self.IdentitySegment.selectedSegmentIndex) {
        case 0:
            NSLog(@"會員");
            break;
            
        default:
            NSLog(@"行政");
            break;
    }
    
}

- (IBAction)sender:(id)sender
{
    [sender resignFirstResponder];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
    self.Job.delegate = self;
    self.Country.delegate = self;
    self.sex.delegate = self;
    self.Address.delegate = self;
    self.AccountLabel.delegate = self;
    self.PasswardLabel.delegate = self;
    self.PasswardCheckLabel.delegate = self;
    self.PhoneNumber.delegate = self;
    self.MobilePhone.delegate = self;
    self.sexpicker.delegate = self;
    
    //給生日欄位建立datepicker
   /* [self.view addSubview:_Birthday];
    [self.view addSubview:_sex];
    [self.view addSubview:sexpicker];
    */sexarray = [NSMutableArray new];
    [sexarray addObject:@"男"];
    [sexarray addObject:@"女"];
    countryarray = [NSMutableArray new];
    [countryarray addObject:@"台灣"];
    [countryarray addObject:@"日本"];
    [countryarray addObject:@"美國"];
    [countryarray addObject:@"中國"];
    [countryarray addObject:@"香港"];
    jobarray = [NSMutableArray new];
    [jobarray addObject:@"公"];
    [jobarray addObject:@"工"];
    [jobarray addObject:@"教"];
    [jobarray addObject:@"軍／警"];
    [jobarray addObject:@"家管"];
    [jobarray addObject:@"商"];
    
    _datepicker = [UIDatePicker new];
    
    NSLocale *datelocale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_TW"];
    self.datepicker.locale = datelocale;
    self.datepicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    
    
    _Birthday.inputView = _datepicker;
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(cancelPicker)];
    
    toolbar.items = [NSArray arrayWithObject:right];
    
    _Birthday.inputAccessoryView = toolbar;
    
}





-(void) cancelPicker{
    if ([self.view endEditing:NO]){
        
        NSDateFormatter *formatter = [NSDateFormatter new];
        NSString *dateformat = [NSDateFormatter dateFormatFromTemplate:@"yyyy/MM/dd" options:0 locale:datelocale];
        [formatter setDateFormat:dateformat];
        [formatter setLocale:datelocale];
        
        _Birthday.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_datepicker.date]];
        
        
        
    }
}
//點擊空白處縮回鍵盤
-(IBAction)backgroundTapped:(id)sender{
    [self.view endEditing:YES];
}




//編輯某些textfield時 將view往上移 避免遮住textfield
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _sex) {
        
        _sex.enabled = NO;
        CGRect frame = self.view.frame;
        frame.origin.y -=0;
        frame.size.height +=0;
        self.view.frame = frame;
        selectedstring = [sexarray objectAtIndex:0];
        
        [MMPickerView showPickerViewInView:self.view
                               withStrings:sexarray
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:selectedstring,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    _sex.text = selectedString;
                                }];
    }else if (textField ==_Country){
        /*
        CGRect frame = self.view.frame;
        frame.origin.y -=0;
        frame.size.height +=0;
        self.view.frame = frame;
         */_Country.enabled = NO;
        selectedstring = [countryarray objectAtIndex:0];
        
        [MMPickerView showPickerViewInView:self.view
                               withStrings:countryarray
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:selectedstring,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    _Country.text = selectedString;
                                }];
    }else if (textField == _Job){
        _Job.enabled = NO;
        selectedstring = [jobarray objectAtIndex:0];
        
        [MMPickerView showPickerViewInView:self.view
                               withStrings:jobarray
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor colorWithRed:0/255.0f green:185/255.0f blue:240/255.0f alpha:1],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:28],
                                             MMvalueY: @3,
                                             MMselectedObject:selectedstring,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    _Job.text = selectedString;
                                }];
    }else if (textField != _Address){
        
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y -=216;
        frame.size.height +=216;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
    }else if (textField == _Address){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y -=30;
        frame.size.height +=30;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
    }
}

    
    
         

//編輯完textfield後 將view移回原位
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    
    if (textField ==_sex){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=0;
        frame.size. height -=0;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
    }else if (textField ==_Country){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=0;
        frame.size. height -=0;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
    }else if (textField == _Job){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=0;
        frame.size. height -=0;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
    }
    else if (textField != _Address){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=216;
        frame.size. height -=216;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
    }else if (textField == _Address){
        NSTimeInterval animationDuration = 0.30f;
        CGRect frame = self.view.frame;
        frame.origin.y +=30;
        frame.size.height -=30;
        self.view.frame = frame;
        [UIView beginAnimations:@"ResizeView" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.view.frame = frame;
        [UIView commitAnimations];
    }
    
}


    








- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)RegisterButton:(id)sender {
    
   [self.AccountLabel resignFirstResponder];
    
    if ([self.PasswardLabel.text isEqualToString:self.PasswardCheckLabel.text]) {
        
         [self PostRegister];
    
    }else{
        
         [self lockAnimationForView:self.PasswardLabel];
         [self lockAnimationForView:self.PasswardCheckLabel];
        
    }
    
    
   
    
}


//註冊
-(void)PostRegister{
    
    NSURL *url = [NSURL URLWithString:@"http://163.13.128.77:8080/jy7/SendRegisterInfo.php"];


    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:20.0];


    NSString *value2 = [[NSString alloc]initWithFormat:@"registerAccount=%@&registerPssword=%@&registerGender=%@&registerCareer=%@&registerNationality=%@&registerID=%@&registerBirthday=%@&registerMail=%@&registerAddress=%@&registerContactPhone=%@&registerPhone=%@&registerPassword=%@",self.AccountLabel.text,self.PasswardLabel.text,self.sex.text,self.Job.text,self.Country.text,self.Idnumber.text,self.Birthday.text,self.Email.text,self.Address.text,self.PhoneNumber.text,self.PhoneNumber.text,self.PasswardLabel.text];
    NSData *postData = [value2 dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];

    request.HTTPMethod = @"POST";
    request.HTTPBody = postData;
    
    
    //Session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data,NSURLResponse *_Nullable response,NSError *_Nullable error){

        NSLog(@"123");
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"html:%@",html);
    
        
        //因為執行緒不能改變UI 所以用這個包起來使用UI
        dispatch_sync(dispatch_get_main_queue(), ^{

            NSLog(@"6666");
            //認證成功
            if ([html isEqualToString:@"ok"]) {

                [self.navigationController popViewControllerAnimated:YES];
                NSLog(@"Success");

            }else{
                NSLog(@"重複");
                

            }

        });



    }];

    [dataTask resume];
    
    
}


//搖動TextField
-(void)lockAnimationForView:(UIView*)view
{
    CALayer *lbl = [view layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-10, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+10, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:6];
    [lbl addAnimation:animation forKey:nil];
}


@end
