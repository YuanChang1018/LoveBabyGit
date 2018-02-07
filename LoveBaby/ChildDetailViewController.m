//
//  ChildDetailViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/3/13.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "ChildDetailViewController.h"
#import "ChildDetailTableViewCell.h"
#import "ChildInfoDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface ChildDetailViewController ()

@end

@implementation ChildDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"兒童資料";
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"ChildDetailReload" object:nil];
    
    //監聽廣播端
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"ChildDetailInfoReload" object:nil];
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self viewDidLoad];
    [self.ChildDetailTableView reloadData];
    NSLog(@"RELOAD");
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ChildMemory = [NSUserDefaults standardUserDefaults];
    
    ChildInfoArray = [[NSMutableArray alloc] init];
    ChildAnsArray = [[NSMutableArray alloc] init];
    
    //TableView ChildDetailTableViewCell 綁定
    [self.ChildDetailTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ChildDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ChildDetailTableViewCell class])];
    
    //小孩資訊欄位名稱
    [ChildInfoArray addObject:@"姓名："];
    [ChildInfoArray addObject:@"性別："];
    [ChildInfoArray addObject:@"身份證字號："];
    [ChildInfoArray addObject:@"生日："];
    [ChildInfoArray addObject:@"註解："];
    
    
    
    
    //這個view是"新增小孩資訊"跟"小孩資訊"兩個共用
    //判斷是不是要"新增小孩" 新增的話顯示"新增小孩資訊"介面
    if ([[ChildMemory objectForKey:@"add"]isEqualToString:@"add"]) {
        
        //會員圖片設定
        UIImage *btnImage = [UIImage imageNamed:@"baby"];
        [self.ChildImageButton setImage:btnImage forState:UIControlStateNormal];
        self.ChildImageButton.layer.cornerRadius = self.ChildImageButton.frame.size.height/8;
        self.ChildImageButton.layer.masksToBounds = YES;
        self.ChildImageButton.layer.borderWidth = 0;

        
        self.AddChildButton.hidden = NO;
        //新增小孩資訊
        [self NewChildInformation];
        
    }else{
        
        //會員圖片設定   //假資料 改成對應小孩圖片url
        NSURL *imageurl = [NSURL URLWithString:@"http://163.13.128.77/Lovebaby/image/hello.jpg"];
        //ImageView設定   套用SDWebImage API 抓取遠端圖片速率快並且記憶體控制穩定
        [self.ChildImageButton sd_setBackgroundImageWithURL:imageurl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"baby"] options:SDWebImageRefreshCached];
        self.ChildImageButton.layer.cornerRadius = self.ChildImageButton.frame.size.height/8;
        self.ChildImageButton.layer.masksToBounds = YES;
        self.ChildImageButton.layer.borderWidth = 0;

        
        self.AddChildButton.hidden = YES;
        //修改小孩資訊
        [self getChildInformation];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ChildInfoArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return @"";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChildDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ChildDetailTableViewCell class]) forIndexPath:indexPath];
    
    
    cell.textLabel.text = [ChildInfoArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [ChildAnsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        [ChildMemory setObject:@"ChildName" forKey:@"ChildInfo"];
    }else if (indexPath.row == 1){
        [ChildMemory setObject:@"ChildSex" forKey:@"ChildInfo"];
    }else if (indexPath.row == 2){
        [ChildMemory setObject:@"ChildId" forKey:@"ChildInfo"];
    }else if (indexPath.row == 3){
        [ChildMemory setObject:@"ChildBirthday" forKey:@"ChildInfo"];
    }else if (indexPath.row == 4){
        [ChildMemory setObject:@"ChildText" forKey:@"ChildInfo"];
    }
    
    ChildInfoDetailViewController *ViewController = [[ChildInfoDetailViewController alloc] init];
    ViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChildDetailReload" object:self userInfo:nil];
    
}




-(void)NewChildInformation{
    
    
    if ([ChildMemory objectForKey:@"ChildAddName"] == nil) {
        
        [ChildAnsArray addObject:@""];
        
    }else{
        
        [ChildAnsArray addObject:[ChildMemory objectForKey:@"ChildAddName"]];
        
    }
    
    if ([ChildMemory objectForKey:@"ChildAddSex"] == nil) {
        
        [ChildAnsArray addObject:@""];
        
    }else{
        
        [ChildAnsArray addObject:[ChildMemory objectForKey:@"ChildAddSex"]];
        
    }
    
    if ([ChildMemory objectForKey:@"ChildAddId"] == nil) {
        
        [ChildAnsArray addObject:@""];
        
    }else{
        
        [ChildAnsArray addObject:[ChildMemory objectForKey:@"ChildAddId"]];
        
    }
    
    if ([ChildMemory objectForKey:@"ChildAddDate"] == nil) {
        
        [ChildAnsArray addObject:@""];
        
    }else{
        
        [ChildAnsArray addObject:[ChildMemory objectForKey:@"ChildAddDate"]];
        
    }
    
    if ([ChildMemory objectForKey:@"ChildAddText"] == nil) {
        
        [ChildAnsArray addObject:@""];
        
    }else{
        
        [ChildAnsArray addObject:[ChildMemory objectForKey:@"ChildAddText"]];
        
    }
   

    
}


//兒童照片選擇
- (IBAction)ChildImageButton:(id)sender {
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate = self;
    
    // bring up the picker
    [self presentViewController:picker animated:YES completion:nil];

}


//選完照片動作
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *UserImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self.ChildImageButton setImage:UserImage forState:UIControlStateNormal];

    NSLog(@"image size:%f",UserImage.size.width);
    
    
    //修改圖片像素大小
    CGSize newSize;
    if (UserImage.size.width > 4000) {
        newSize = CGSizeMake(1334.0f, 1000.0f);
    }else{
        newSize = CGSizeMake(1000.0f, 1334.0f);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [UserImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    ///////////////////
    

    
    //上傳圖片 function
    [self uploadPhotoWithImage:newImage success:nil fail:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}



//搜尋資料庫小孩資料 假資料
-(void)getChildInformation{
    
    //抓取資料庫小孩資訊 顯示這邊
    NSString *ChildInfoName = @"陳賤成";
    NSString *ChildInfoSex = @"男";
    NSString *ChildInfoId = @"V1212334565";
    NSString *ChildInfoDate = @"1999/3/14";
    NSString *ChildInfoText = @"很乖";
    
    
    [ChildAnsArray addObject:ChildInfoName];
    [ChildAnsArray addObject:ChildInfoSex];
    [ChildAnsArray addObject:ChildInfoId];
    [ChildAnsArray addObject:ChildInfoDate];
    [ChildAnsArray addObject:ChildInfoText];
    
    [ChildMemory setObject:ChildInfoName forKey:@"ChildInfoName"];
    [ChildMemory setObject:ChildInfoSex forKey:@"ChildInfoSex"];
    [ChildMemory setObject:ChildInfoId forKey:@"ChildInfoId"];
    [ChildMemory setObject:ChildInfoDate forKey:@"ChildInfoDate"];
    [ChildMemory setObject:ChildInfoText forKey:@"ChildInfoText"];
    
    
}



//上傳新增小孩資料
- (IBAction)addChildButton:(id)sender {
    
    //這些String要上傳新增到遠端資料庫 
    NSString *ChildAddName = [ChildMemory objectForKey:@"ChildAddName"];
    NSString *ChildAddSex = [ChildMemory objectForKey:@"ChildAddSex"];
    NSString *ChildAddId = [ChildMemory objectForKey:@"ChildAddId"];
    NSString *ChildAddDate = [ChildMemory objectForKey:@"ChildAddDate"];
    NSString *ChildAddText = [ChildMemory objectForKey:@"ChildAddText"];
    
    
    //新增完畢之後清空
    [ChildMemory setObject:nil forKey:@"ChildAddName"];
    [ChildMemory setObject:nil forKey:@"ChildAddSex"];
    [ChildMemory setObject:nil forKey:@"ChildAddId"];
    [ChildMemory setObject:nil forKey:@"ChildAddDate"];
    [ChildMemory setObject:nil forKey:@"ChildAddText"];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

///////////上傳圖片
- (void)uploadPhotoWithImage:(UIImage *)image success:(void (^)(NSDictionary *dictionary))successBlock fail:(void (^)(NSError *error))failBlock
{
    
    NSURL *url = [NSURL URLWithString:@"http://163.13.128.77/Lovebaby/uploadimage.php"];
    
    //上傳大頭貼圖片要存的檔名                                          //"baby" 假資料
    NSString *ImageFileName = [NSString stringWithFormat:@"%@.jpg",@"baby"];
    
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
