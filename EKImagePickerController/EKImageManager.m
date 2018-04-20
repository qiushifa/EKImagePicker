//
//  EKImageManager.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKImageManager.h"
#import "EKAlbumModel.h"


@implementation EKImageManager

+ (instancetype)manager {
    static EKImageManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
- (NSArray<PHAssetCollection *> *)getAllAlbums{
    NSMutableArray *dataArray = [NSMutableArray array];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    [dataArray addObject:[smartAlbumsFetchResult objectAtIndex:0]];
    
    PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
    for (PHAssetCollection *sub in smartAlbumsFetchResult1) {
        [dataArray addObject:sub];
    }
    return dataArray;
}

-(PHFetchResult *)getFetchResult:(PHAssetCollection *)assetCollection{
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    return fetchResult;
}

- (NSMutableArray<PHAsset *> *)getPhotoAssets:(PHFetchResult *)fetchResult assetType:(PHAssetMediaType)type{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (PHAsset *asset in fetchResult) {
        if (asset.mediaType  ==  type) {
            [dataArray addObject:asset];
        }
    }
    return dataArray;
}


-(PHFetchResult *)getCameraRollFetchResult{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    PHFetchResult *fetch = [PHAsset fetchAssetsInAssetCollection:[smartAlbumsFetchResult objectAtIndex:0] options:nil];
    return fetch;
}

-(void)getImageObject:(id)asset complection:(void (^)(UIImage *image, BOOL))complection{
    
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset *)asset;
        CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
        //屏幕分辨率 scale = 1 代表 分辨率是320 * 480; = 2 代表 分辨率是 640 * 960; = 3 代表 分辨率是 1242 * 2208
        CGFloat multiple = [UIScreen mainScreen].scale;
        CGFloat pixelWidth = photoWidth * multiple;
        CGFloat pixelHeight = pixelWidth / aspectRatio;
    
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            // 排除取消，错误，低清图三种情况，即已经获取到了高清图
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined) {
                //回调
                if (complection){
                    complection(result,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
                }
            }
            
        }];
    }
}

@end
