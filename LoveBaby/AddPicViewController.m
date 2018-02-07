//
//  AddPicViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/12.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "AddPicViewController.h"
#import "AddPicTableViewCell.h"
#import "PicEditViewController.h"

@interface AddPicViewController ()

@end

@implementation AddPicViewController

-(void)viewDidAppear:(BOOL)animated{
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        if (self.view.frame.size.width == 320) {
            
            self.imageButton.frame = CGRectMake(0, 10, 320, 203);
            self.PicTableview.frame = CGRectMake(0, 210, 320, 600);
            self.PicScrollView.contentSize = CGSizeMake(320,600);
            
        }else if (self.view.frame.size.width == 375){
            
            self.imageButton.frame = CGRectMake(0, 10, 375, 203);
            self.PicTableview.frame = CGRectMake(0, 210, 375, 600);
            self.PicScrollView.contentSize = CGSizeMake(375,800);
            
        }else if (self.view.frame.size.width == 414){
            
            self.imageButton.frame = CGRectMake(0, 10, 414, 203);
            self.PicTableview.frame = CGRectMake(0, 210, 414, 600);
            self.PicScrollView.contentSize = CGSizeMake(414,800);
        }
    });
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"新增相片";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"上傳" style:UIBarButtonItemStylePlain target:self action:@selector(uploadPic:)];
    
    Buttonitem.tintColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
    
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"AddPicReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self.PicTableview reloadData];
    NSLog(@"AddPicReload");
    
}






//上傳相片按鈕
-(IBAction)uploadPic:(id)sender{
    
    PicDate = [PicMemory objectForKey:@"PicDate"];
    
    
    
    //上傳圖片 function
    [self uploadPhotoWithImage:newImage success:nil fail:nil];
    
    //上傳圖片日期 圖片文字
    NSLog(@"PicDate：%@",PicDate);
    NSLog(@"PicText：%@",PicText);
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PicMemory = [NSUserDefaults standardUserDefaults];
    
    self.imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageButton.imageView.clipsToBounds = YES;
    
        
    
    //TableView設定
    [self.PicTableview registerNib:[UINib nibWithNibName:NSStringFromClass([AddPicTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AddPicTableViewCell class])];


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AddPicTableViewCell class]) forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        
        cell.cellQuestionLabel.text = @"時間：";
        cell.CellAnsLabel.text = [PicMemory objectForKey:@"PicDate"];
        cell.CellTextView.hidden = YES;
        
        
    }else if (indexPath.row == 1){
        
        cell.CellTextView.delegate = self;
        cell.cellQuestionLabel.text = @"活動：";
        cell.CellAnsLabel.text = @"";
        cell.CellTextView.layer.cornerRadius = cell.CellTextView.frame.size.height/6;
        cell.CellTextView.layer.masksToBounds = YES;
        cell.CellTextView.layer.borderWidth = 0;
        cell.CellTextView.hidden = NO;
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddPicReload" object:self userInfo:nil];
    
    if (indexPath.row == 0) {
        
        PicEditViewController *viewcontroller = [[PicEditViewController alloc] init];
        [self.navigationController pushViewController:viewcontroller animated:YES];
    
    }

    
     [self.view endEditing:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{ //列表每一格的間隔
    
    if (indexPath.row == 1) {
        return 120;
    }
    
    return 60;
}



//圖片按鈕
- (IBAction)imageButton:(id)sender {
    
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.delegate = self;
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    //可選影片跟照片
    videoPicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //只能選影片
    //videoPicker.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    
    videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    [self presentViewController:videoPicker animated:YES completion:nil];
}



//選完照片動作
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //分類選擇的是影片或照片
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSLog(@"media type:%@",mediaType);
    
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *UserImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        //修改圖片像素大小
        CGSize newSize;
        if (UserImage.size.width > 4000) {
            newSize = CGSizeMake(1334.0f, 1000.0f);
        }else{
            newSize = CGSizeMake(1000.0f, 1334.0f);
        }
        
        UIGraphicsBeginImageContext(newSize);
        [UserImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        [self.imageButton setImage:newImage forState:UIControlStateNormal];
        //NSData *imageData = UIImageJPEGRepresentation(newImage, 0.7);
        
        
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//Done收鍵盤
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    PicText = textView.text;
    
}



///////////上傳圖片
- (void)uploadPhotoWithImage:(UIImage *)image success:(void (^)(NSDictionary *dictionary))successBlock fail:(void (^)(NSError *error))failBlock
{
    
    NSURL *url = [NSURL URLWithString:@"http://163.13.128.77/Lovebaby/uploadimage.php"];
    
    //上傳大頭貼圖片要存的檔名                                          //"test" 假資料
    NSString *ImageFileName = [NSString stringWithFormat:@"%@.jpg",@"test"];
    
    // Build the request body
    NSString *boundary = @"Happyboundary";
    NSMutableData *body = [NSMutableData data];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", @"userfile",ImageFileName] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Setup the session
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"Authorization" : [@"Bearer " stringByAppendingString:@"Happy Authorization"],
                                                   @"Content-Type"  : [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary]
                                                   };
    
    // Create the session
    // We can use the delegate to track upload progress
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:nil delegateQueue:nil];
    
    // Data uploading task. We could use NSURLSessionUploadTask instead of NSURLSessionDataTask if we needed to support uploads in the background
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = body;
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            
            if (error == nil) {
                // Success
                NSLog(@"response %@", html);
                
            }
            else {
                // Failure
                NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
                failBlock(error);
                
            }
        });
    }];
    [uploadTask resume];
}




@end
