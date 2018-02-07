//
//  PicDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "PicDetailViewController.h"

@interface PicDetailViewController ()

@end

@implementation PicDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //Bool
    
    PicMemory = [NSUserDefaults standardUserDefaults];
    
    
    
    NSString *PicURL = [PicMemory objectForKey:@"PicURL"];
    NSLog(@"PicURL : %@",PicURL);
    NSURL *imageurl = [NSURL URLWithString:PicURL];
    NSData *imagedata = [NSData dataWithContentsOfURL:imageurl];
    self.ImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.ImageView.image = [UIImage imageWithData:imagedata];
    
    shouldHideStatusBar = NO;
    shouldHideItemBar = NO;
    
}

- (BOOL)prefersStatusBarHidden {
    return shouldHideStatusBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//螢幕觸碰感應
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"123123");
    shouldHideStatusBar = (shouldHideStatusBar)? NO: YES;
    shouldHideItemBar = (shouldHideItemBar)? NO : YES;
    self.navigationController.navigationBarHidden = shouldHideItemBar;
    [self setNeedsStatusBarAppearanceUpdate];
}


@end
