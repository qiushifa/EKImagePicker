//
//  EKPhotoPreviewCell.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface EKPhotoPreviewCell : UICollectionViewCell
@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, copy) void (^singleTapGestureBlock)(void);

- (void)recoverSubviews; // 恢复原视图
@end
