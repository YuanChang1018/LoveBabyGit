//
//  InformationViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/2/15.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationTableViewCell.h"
#import "UserDetailViewController.h"
#import "ChildrenViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>




@interface InformationViewController ()

@end

@implementation InformationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"個人資料";
    
    //監聽廣播端 點選更新畫面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"reload" object:nil];
    
    //監聽廣播端 編輯完更新畫面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload:) name:@"InfoReload" object:nil];
    
    
    
}

//reload方法
-(void)reload:(NSNotification *)notification{
    
    [self viewDidLoad];
    NSLog(@"RELOAD");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UserInfo = [NSUserDefaults standardUserDefaults];
    
    //User資訊是nil的話顯示"空"
    if ([UserInfo objectForKey:@"UserName"] == nil) {
        [UserInfo setObject:@"" forKey:@"UserName"];
    }
    if ([UserInfo objectForKey:@"UserEnglishName"] == nil) {
        [UserInfo setObject:@"" forKey:@"UserEnglishName"];
    }
    if ([UserInfo objectForKey:@"UserSex"] == nil){
        [UserInfo setObject:@"" forKey:@"UserSex"];
    }
    if ([UserInfo objectForKey:@"UserID"] == nil){
        [UserInfo setObject:@"" forKey:@"UserID"];
    }
    if ([UserInfo objectForKey:@"UserBirthday"] == nil){
        [UserInfo setObject:@"" forKey:@"UserBirthday"];
    }
    if ([UserInfo objectForKey:@"UserEmail"] == nil){
        [UserInfo setObject:@"" forKey:@"UserEmail"];
    }
    if ([UserInfo objectForKey:@"UserAdress"] == nil){
        [UserInfo setObject:@"" forKey:@"UserAdress"];
    }
    if ([UserInfo objectForKey:@"UserPhone"] == nil){
        [UserInfo setObject:@"" forKey:@"UserPhone"];
    }
    
    
    
    //TableView InformationTableViewCell 宣告綁定
    [self.UserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([InformationTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([InformationTableViewCell class])];
    
    
    //會員圖片設定  抓取遠端伺服器圖片 假資料
    NSURL *imageurl = [NSURL URLWithString:@"http://163.13.128.77/Lovebaby/image/hello.jpg"];
    //UIImage *imageURL = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
    //[self.UserImageButton setImage:imageURL forState:UIControlStateNormal];
    //[self.UserImageButton sd_setBackgroundImageWithURL:imageurl forState:UIControlStateNormal];
    
    //ImageView設定   套用SDWebImage API 抓取遠端圖片速率快並且記憶體控制穩定
    [self.UserImageButton sd_setBackgroundImageWithURL:imageurl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"addpicture"] options:SDWebImageRefreshCached];
    
    self.UserImageButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.UserImageButton.imageView.clipsToBounds = YES;
    self.UserImageButton.frame = CGRectMake(self.view.frame.size.width/2 - self.UserImageButton.frame.size.width/2, 10, 120, 120);
    self.UserImageButton.layer.cornerRadius = self.UserImageButton.frame.size.height/8;
    self.UserImageButton.layer.masksToBounds = YES;
    self.UserImageButton.layer.borderWidth = 0;
    
    
    //依照手機尺寸 修改畫面大小
    NSLog(@"View Width : %f",self.view.frame.size.width);
    if (self.view.frame.size.width == 320) {
        
        self.UserScrollView.contentSize = CGSizeMake(300, 600);
        self.UserTableView.frame = CGRectMake(0, 139, 320, 464);
    
    }else if (self.view.frame.size.width == 375){
        
        self.UserScrollView.contentSize = CGSizeMake(300, 700);
        self.UserTableView.frame = CGRectMake(0, 139, 375, 600);
        
    }else if (self.view.frame.size.width == 414){
        
        self.UserScrollView.contentSize = CGSizeMake(300, 700);
        self.UserTableView.frame = CGRectMake(0, 139, 414, 600);
        
    }
    
    
    //資訊欄位  因為要做到分割兩個區塊所以採取"雙陣列"方式
    ///////////////////////////////
    InfoArray = [[NSMutableArray alloc] init];
    InfoArray2 = [[NSMutableArray alloc] init];
    
    [InfoArray addObject:@""];
    [InfoArray addObject:@"設定親屬關係"];
    [InfoArray addObject:@"名字："];
    [InfoArray addObject:@"英文名字："];
    [InfoArray addObject:@"性別："];
    [InfoArray addObject:@"身份證字號："];
    [InfoArray addObject:@"出生日期："];
    
    [InfoArray2 addObject:InfoArray];
    
    ///////////////////////////////
    
    InfoArray = [[NSMutableArray alloc] init];
    
    [InfoArray addObject:@""];
    [InfoArray addObject:@"電子郵件："];
    [InfoArray addObject:@"通訊地址："];
    [InfoArray addObject:@"電話："];
 
    [InfoArray2 addObject:InfoArray];
    
    ///////////////////////////////
    
    for (int i = 0; i < 10; i++) {
        
        InfoArray = [[NSMutableArray alloc] init];
        
        [InfoArray addObject:@""];
        
        
        [InfoArray2 addObject:InfoArray];

    }
    
    
    
    //InfoAnswer
    /////////////////////////////////
    
    InfoAnswerArray = [[NSMutableArray alloc] init];
    InfoAnswerArray2 = [[NSMutableArray alloc] init];
    
    //從使用者設定抓取 儲存的資料
    NSString *UserName = [UserInfo objectForKey:@"UserName"];
    NSString *UserEnglishName = [UserInfo objectForKey:@"UserEnglishName"];
    NSString *UserSex = [UserInfo objectForKey:@"UserSex"];
    NSString *UserPosition = [UserInfo objectForKey:@"UserID"];
    NSString *UserDirthday = [UserInfo objectForKey:@"UserBirthday"];
    NSString *UserInterest = [UserInfo objectForKey:@"UserEmail"];
    NSString *UserCompany = [UserInfo objectForKey:@"UserAdress"];
    NSString *UserLocation = [UserInfo objectForKey:@"UserPhone"];
    
    [InfoAnswerArray addObject:@""];
    [InfoAnswerArray addObject:UserName];
    [InfoAnswerArray addObject:UserEnglishName];
    [InfoAnswerArray addObject:UserSex];
    [InfoAnswerArray addObject:UserPosition];
    [InfoAnswerArray addObject:UserDirthday];
   
    
    [InfoAnswerArray2 addObject:InfoAnswerArray];
    
    InfoAnswerArray = [[NSMutableArray alloc] init];
    [InfoAnswerArray addObject:UserInterest];
    [InfoAnswerArray addObject:UserCompany];
    [InfoAnswerArray addObject:UserLocation];
    
    
    [InfoAnswerArray2 addObject:InfoAnswerArray];
    
    
    //抓取完資料 更新TableView
    [self.UserTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [InfoArray2 count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[InfoArray2 objectAtIndex:section] count] - 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [[InfoArray2 objectAtIndex:section] objectAtIndex:0];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InformationTableViewCell class]) forIndexPath:indexPath];
    
   
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if (section == 0 && row == 0) {
        cell.textLabel.tintColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    cell.detailTextLabel.text = [[InfoAnswerArray2 objectAtIndex:section] objectAtIndex:row];
    
    cell.textLabel.text = [[InfoArray2 objectAtIndex:section] objectAtIndex:row + 1];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    
    
    return cell;
}


//點選動作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];

    if (section == 0 && row == 0) {
        
        
        ChildrenViewController *ViewController = [[ChildrenViewController alloc]init];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
        
        
    }else if (section == 0 && row == 1) {
        
        //代表點選"name"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"name" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:ViewController animated:YES];
        

        
    }else if (section == 0 && row == 2){
        
        //代表點選"englishname"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"englishname" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    }else if (section == 0 && row == 3){
        
        //代表點選"englishname"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"sex" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    }else if (section == 0 && row == 4){
        
        //代表點選"englishname"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"id" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    }else if (section == 0 && row == 5){
        
        //代表點選"birthday"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"birthday" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
        
    }else if (section == 1 && row == 0){
        
        //代表點選"email"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"email" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
    }else if (section == 1 && row == 1){
        
        //代表點選"adress"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"adress" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];

        
    }else if (section == 1 && row == 2){
        
        //代表點選"phone"這個欄位 下個view要用來判斷
        [UserInfo setObject:@"phone" forKey:@"UserInfo"];
        
        UIViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetail"];
        ViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ViewController animated:YES];
        
    }
   
    
    //發出廣播端
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InfoReload" object:self userInfo:nil];
    
    NSLog(@"Section : %ld",(long)section);
    NSLog(@"IndexPath : %ld",(long)row);
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}




//點選大頭照 做動作
//會員照片選擇
- (IBAction)UserImageButton:(id)sender {
    
    //圖片挑選畫面
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = NO;
    picker.delegate = self;
    
    //make sure we include Live Photos (otherwise we'll only get UIImages)
    //NSArray *mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeLivePhoto];
    //picker.mediaTypes = mediaTypes;
    
    // bring up the picker
    [self presentViewController:picker animated:YES completion:nil];
    
    
    NSLog(@"imageButton");
}




//選完照片動作
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *UserImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.UserImageButton setImage:UserImage forState:UIControlStateNormal];
    
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
