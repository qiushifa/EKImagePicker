//
//  EKPhotoListViewController.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/19.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKPhotoListViewController : UIViewController
@property (strong, nonatomic) void (^photoResult)(id responseObject);
@end
