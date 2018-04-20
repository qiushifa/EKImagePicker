//
//  EKAssetModel.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EKAssetModelMediaType){
    EKAssetModelMediaTypePhoto = 0,
    EKAssetModelMediaTypeLivePhoto,
    EKAssetModelMediaTypeVideo,
    EKAssetModelMediaTypeAudio,
};

@class PHAsset;

@interface EKAssetModel : NSObject
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) BOOL isSelected;  // 选中状态
@property (nonatomic, assign) EKAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;

+ (instancetype)modelWithAsset:(id)asset type:(EKAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(EKAssetModelMediaType)type timeLength:(NSString *)timeLength;


@end
