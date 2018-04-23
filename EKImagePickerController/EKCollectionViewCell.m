//
//  EKCollectionViewCell.m
//  EKImagePickerView
//
//  Created by lilong on 2018/4/16.
//  Copyright © 2018年 jinding. All rights reserved.
//

#import "EKCollectionViewCell.h"
#import "UIView+EKValue.h"

#define DEL_BTN_WH RELATIVE_VALUE(24)

@implementation EKCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        _imageThumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.ek_width, self.ek_height)];
        _imageThumbnail.contentMode = UIViewContentModeScaleToFill;
        _imageThumbnail.layer.cornerRadius = 5;
        _imageThumbnail.layer.masksToBounds = YES;
        _imageThumbnail.clipsToBounds = YES;
        [self addSubview:_imageThumbnail];
        
        _nookDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self setupDeleteBtn:DEL_BTN_WH];
        [self addSubview:_nookDeleteBtn];
    }
    return self;
}

- (void)setupDeleteBtn:(CGFloat)width {
    _nookDeleteBtn.frame = CGRectMake(self.ek_width - 24 , 0 , width, width);
    _nookDeleteBtn.alpha = 1.0;
    [_nookDeleteBtn setImage:[UIImage imageNamed:@"nookDeleteBtn"] forState:UIControlStateNormal];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isHidden) {
        CGPoint delBtnTouchPoint = [self convertPoint:point toView:self.nookDeleteBtn];
        if ( [self.nookDeleteBtn pointInside:delBtnTouchPoint withEvent:event] && !self.nookDeleteBtn.isHidden) {
            return self.nookDeleteBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageThumbnail.frame = self.bounds;
}

@end
