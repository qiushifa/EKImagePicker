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

    CGFloat btnSize = self.ek_width / 4;
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(self.ek_width - btnSize, 0, btnSize, btnSize);
    [self.contentView addSubview:_selectBtn];
}

-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(PHAsset *)assetItem{
    if ([selectArray containsObject:assetItem]) {
        [_selectBtn setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
    }
}

-(void)loadPhotoData:(PHAsset *)assetItem{
    if ([assetItem isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = assetItem;
        PHImageRequestOptions *options = [PHImageRequestOptions new];
        [[PHImageManager defaultManager]requestImageForAsset:phAsset targetSize:CGSizeMake(self.ek_width, self.ek_width) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            self.imageView.image = result;
        }];
    }
}
                                    
                                       
@end
