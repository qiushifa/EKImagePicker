//
//  EKAssetCell.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKAssetCell.h"
#import "UIView+EKValue.h"
#import <Photos/Photos.h>
#import "UIImage+EKFixOrientation.h"
#import "EKImageManager.h"

@interface EKAssetCell()
@property (nonatomic, strong) UIImageView *imageView;
@end


@implementation EKAssetCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUILayout];
    }
    return self;
}
//界面布局
-(void)setUILayout{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.ek_width, self.ek_width)];
    _imageView.layer.masksToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageView];
    
//    CGFloat btnSize = photoSize / 4;
//    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(photoSize - btnSize - 5, 5, btnSize, btnSize)];
//    [self.contentView addSubview:_selectBtn];
}

- (void)setModel:(EKAssetModel *)model {
    if (model.asset.mediaType == PHAssetMediaTypeImage) {
        __block UIImage *img = [UIImage imageNamed:@""];
        [[EKImageManager manager] getImageObject:model.asset complection:^(UIImage *image, BOOL isDegraded) {
            img = image;
        }];
        self.imageView.image = img;
    }
    [self.contentView addSubview:self.imageView];
    
}


- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, self.ek_width, self.ek_height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}
                                                                           
                                       
                                       
@end
