//
//  PictureViewController.h
//  LoveBaby
//
//  Created by seae2145 on 2017/4/6.
//  Copyright © 2017年 seae2145. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    NSUserDefaults *PicMemory;
    NSMutableArray *PicURLArray;
}
@property (strong, nonatomic) IBOutlet UICollectionView *PicCollectionView;

@end
