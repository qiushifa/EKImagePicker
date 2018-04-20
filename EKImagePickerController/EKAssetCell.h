//
//  EKAssetCell.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "EKAsset.h"

@interface EKAssetCell : UICollectionViewCell

@property (nonatomic, strong) PHAsset *model;
//@property (nonatomic, assign) EKAssetModelMediaType type;
@property (nonatomic, copy) void (^selectBlock)(PHAsset *asset);

@end
