//
//  EKImageManager.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKAlbumModel.h"
#import <Photos/Photos.h>

@interface EKImageManager : NSObject

+ (instancetype)manager;

- (NSArray<PHAssetCollection *> *)getAllAlbums; 
- (PHFetchResult *)getFetchResult:(PHAssetCollection *)assetCollection;
- (PHFetchResult *)getCameraRollFetchResult;
- (NSMutableArray<PHAsset *> *)getPhotoAssets:(PHFetchResult *)fetchResult  assetType:(PHAssetMediaType)type;//
/*
 *    回调方法使用数组
 */
-(void)getImageObject:(id)asset complection:(void (^)(UIImage *image, BOOL isDegraded))complection;

@end
