//
//  EKPhotoListCell.h
//  EKImagePickerController
//
//  Created by lilong on 2018/4/20.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface EKPhotoListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *coverImage;/** 显示相册的最后一张图片 */
@property (strong, nonatomic) UILabel *title;/** 相册标题，显示相册标题 */
@property (strong, nonatomic) UILabel *subTitle;/** 显示相册中含有多少张图片 */
/**
 *  加载数据方法
 *  @param assetItem 某个相册
 */
-(void)loadPhotoListData:(PHAssetCollection *)assetItem;
@end
