//
//  EKPhotoPreviewController.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKPhotoPreviewController : UIViewController

/**
 必须使用此方法初始化
 @param photos 预览图片数组
 @param index 展示的图片位置
 
 */
- (instancetype)initWithPhotos:(NSArray *)photos atIndex:(NSUInteger)index;

/**
 * 点击底部完成按钮回调
 */
@property (nonatomic, copy) void (^doneBlock)(NSArray *photos);

@end
