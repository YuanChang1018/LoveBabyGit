//
//  PictureViewController.m
//  LoveBaby
//
//  Created by seae2145 on 2017/4/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import "PictureViewController.h"
#import "PicCollectionViewCell.h"
#import "PicInfoViewController.h"
#import "PicDetailViewController.h"
#import "AddPicViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PictureViewController ()

@end

@implementation PictureViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Back返回鍵
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage =[UIImage imageNamed:@"back"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage =[UIImage imageNamed:@"back"];
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    self.navigationItem.title = @"相片";
    
    UIBarButtonItem *Buttonitem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(addPic:)];
    
    Buttonitem.image = [UIImage imageNamed:@"add"];
    Buttonitem.tintColor = [UIColor colorWithRed:255/255.0f green:221/255.0f blue:51/255.0f alpha:1];
    self.navigationItem.rightBarButtonItem = Buttonitem;
    
}


//增加相片按鈕
-(IBAction)addPic:(id)sender{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *locationDate = [formatter stringFromDate:[NSDate date]];
    
    [PicMemory setObject:locationDate forKey:@"PicDate"];

    
    AddPicViewController *ViewController = [[AddPicViewController alloc] init];
    [self.navigationController pushViewController:ViewController animated:YES];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PicMemory = [NSUserDefaults standardUserDefaults];
    
    [self.PicCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    PicURLArray = [[NSMutableArray alloc] init];
    
    
    //假資料  要改成依帳號ID搜索資料庫 找到對應的檔案名稱
    [PicURLArray addObject:@"http://163.13.128.77/Lovebaby/image/hello.jpg"];
    [PicURLArray addObject:@"http://163.13.128.77/Lovebaby/image/test1.jpg"];
    [PicURLArray addObject:@"http://163.13.128.77/Lovebaby/image/HelloVideo.jpg"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [PicURLArray count];
}


//設置 Cell內容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.cellimage.contentMode = UIViewContentModeScaleAspectFill;
    cell.cellimage.clipsToBounds = YES;
    
    NSURL *imageurl = [NSURL URLWithString:[PicURLArray objectAtIndex:indexPath.row]];
    
    [cell.cellimage sd_setImageWithURL:imageurl placeholderImage:[UIImage imageNamed:@"addpicture"] options:SDWebImageRefreshCached];

    return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [PicMemory setObject:[PicURLArray objectAtIndex:indexPath.row] forKey:@"PicURL"];
    
    PicInfoViewController *viewcontroller = [[PicInfoViewController alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
    
}


//設置 cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.view.frame.size.width == 320) {
        
        return CGSizeMake(140, 140);
        
        
    }else if (self.view.frame.size.width == 375) {
        
        return CGSizeMake(110, 110);
        
        
    }else{
        
        return CGSizeMake(120, 120);
        
    }
    
    
    
}


//設置 頭頂距離大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 10);
    
}



//設置 cell最小間距空間大小
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 5;
}


//設置 cell最小間距空間大小
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    
    return 10;
    
}


//設置 cell間距大小
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(1, 10, 1, 10);

}


@end
