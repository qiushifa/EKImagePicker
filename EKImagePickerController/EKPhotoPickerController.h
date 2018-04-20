//
//  EKPhotoPickerController.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>

@interface EKPhotoPickerController : UIViewController

@property (nonatomic, assign) NSUInteger maxCount; // 最大选择张数
@property (nonatomic, assign) BOOL scrollBottom; // 是否滚动到底部，默认YES
@property (nonatomic, assign) CGFloat margin; // cell 间距,默认5
@property (nonatomic, assign) NSInteger columnNumber; // 列数,默认为4
@property (strong, nonatomic) PHFetchResult *fetch;
@property (nonatomic, copy) NSString *titleStr; // 标题

@property (nonatomic, copy) void (^selectedPhotos)(NSArray *photos);

@end
