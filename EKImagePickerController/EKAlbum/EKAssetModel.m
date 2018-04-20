//
//  EKAssetModel.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKAssetModel.h"

@implementation EKAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(EKAssetModelMediaType)type{
    EKAssetModel *model = [[EKAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(EKAssetModelMediaType)type timeLength:(NSString *)timeLength {
    EKAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end
