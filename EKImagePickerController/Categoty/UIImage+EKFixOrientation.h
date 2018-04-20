//
//  UIImage+EKFixOrientation.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (EKFixOrientation)
/// 修正图片转向
- (UIImage *)fixOrientation:(UIImage *)aImage;
@end
