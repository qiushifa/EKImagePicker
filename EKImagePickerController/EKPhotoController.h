//
//  EKPhotoController.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/20.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^EKPhotoResult)(id responseObject);
@interface EKPhotoController : NSObject

@property (assign, nonatomic) NSInteger selectPhotoOfMax;/**< 选择照片的最多张数 */

//@property (assign, nonatomic) XFImageType imageType;/**< 设置图片的返回类型 */

/** 回调方法 */
-(void)showIn:(UIViewController *)controller result:(EKPhotoResult)result;

@end
