//
//  EKCollectionViewCell.h
//  EKImagePickerView
//
//  Created by lilong on 2018/4/16.
//  Copyright © 2018年 jinding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageThumbnail; /** 图片缩略图 */
@property (strong, nonatomic) UIButton *nookDeleteBtn;  /** 角标删除按钮 */
@end
