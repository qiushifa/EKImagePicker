//
//  EKAssetCell.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKAssetModel.h"
#import <Photos/Photos.h>

@interface EKAssetCell : UICollectionViewCell
@property (nonatomic, strong) EKAssetModel *model;
@property (nonatomic, assign) EKAssetModelMediaType type;

@property (nonatomic, assign) BOOL showSelectBtn;


@end
