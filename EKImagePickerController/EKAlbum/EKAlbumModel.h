//
//  EKAlbumModel.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHFetchResult;

@interface EKAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;   //相薄名字
@property (nonatomic, assign) NSInteger count;  //相片总量
@property (nonatomic, strong) PHFetchResult *result;

@end
