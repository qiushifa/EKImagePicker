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
@property (nonatomic, strong) UIButton *selectBtn;
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
    
    CGFloat btnSize = self.ek_width / 5;
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.ek_width - btnSize, 0, btnSize, btnSize)];
    [_selectBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
    [self.contentView insertSubview:_selectBtn aboveSubview:_imageView];
}

- (void)setModel:(PHAsset *)model {
    if (model.mediaType == PHAssetMediaTypeImage) {
        __block UIImage *img = [UIImage imageNamed:@""];
        [[EKImageManager manager] getImageObject:model complection:^(UIImage *image, BOOL isDegraded) {
            img = image;
        }];
        self.imageView.image = img;
    }
    [self.contentView addSubview:self.imageView];
    
    
    
//    if (!model.selected) {
//        [_selectBtn setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
//    }else{
//        [_selectBtn setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
//    }
    
}
- (void)btnPressed:(id)sender{
    
    self.selectBlock(self.model);
    
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
