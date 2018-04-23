//
//  EKImageView.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/23.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKImagesViewDelegate <NSObject>

@end

@interface EKImageView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (assign, nonatomic) NSUInteger maxPhotosCount; //最大可选照片数
@property (strong, nonatomic) NSMutableArray *allPhotos; //展示的照片 UIImage数组
@property (weak, nonatomic) UIViewController<EKImagesViewDelegate>* navcDelegate;
@property (nonatomic,copy) void (^selectedPhotosBlock)(NSArray *photos);
// 用此方法初始化
- (instancetype)initWithFrame:(CGRect)frame withPhotos:(NSArray *)photos;
@end
