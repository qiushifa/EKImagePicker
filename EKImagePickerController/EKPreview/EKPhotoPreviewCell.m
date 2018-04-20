//
//  EKPhotoPreviewCell.m
//  EKImagePickerController
//
//  Created by lilong on 2018/4/18.
//  Copyright © 2018年 qiushifa. All rights reserved.
//

#import "EKPhotoPreviewCell.h"
#import "UIView+EKValue.h"
#import "EKImageManager.h"

@interface EKPhotoPreviewCell()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;

@end

@implementation EKPhotoPreviewCell

- (void)setAsset:(PHAsset *)asset{
    [_scrollView setZoomScale:1.0 animated:NO];
    if (asset.mediaType == PHAssetMediaTypeImage) {
        __block UIImage *img = [UIImage imageNamed:@""];
        [[EKImageManager manager] getImageObject:asset complection:^(UIImage *image, BOOL isDegraded) {
            img = image;
        }];
        self.imageView.image = img;
    }
    
    
}

- (void)setImage:(UIImage *)image{
    [_scrollView setZoomScale:1.0 animated:NO];
    self.imageView.image = image;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(10, 0, self.ek_width - 20, self.ek_height);
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        [self addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        _imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageContainerView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [_imageContainerView addSubview:_imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
    }
    return self;
}

#pragma mark - UITapGestureRecognizer Event

- (void)singleTap:(UITapGestureRecognizer *)tap {
    if (self.singleTapGestureBlock) {
        self.singleTapGestureBlock();
    }
}

- (void)recoverSubviews {
    [_scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
}

- (void)resizeSubviews {
    _imageContainerView.ek_origin = CGPointZero;
    _imageContainerView.ek_width = self.scrollView.ek_width;
    
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.ek_height / self.scrollView.ek_width) {
        _imageContainerView.ek_height = floor(image.size.height / (image.size.width / self.scrollView.ek_width));
    } else {
        CGFloat height = image.size.height / image.size.width * self.scrollView.ek_width;
        if (height < 1 || isnan(height)) height = self.ek_height;
        height = floor(height);
        _imageContainerView.ek_height = height;
        _imageContainerView.ek_centerY = self.ek_height / 2;
    }
    if (_imageContainerView.ek_height > self.ek_height && _imageContainerView.ek_height - self.ek_height <= 1) {
        _imageContainerView.ek_height = self.ek_height;
    }
    CGFloat contentSizeH = MAX(_imageContainerView.ek_height, self.ek_height);
    _scrollView.contentSize = CGSizeMake(self.scrollView.ek_width, contentSizeH);
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _scrollView.alwaysBounceVertical = _imageContainerView.ek_width <= self.ek_height ? NO : YES;
    _imageView.frame = _imageContainerView.bounds;
    
    
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}

#pragma mark - Private

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (_scrollView.ek_width > _scrollView.contentSize.width) ? ((_scrollView.ek_width - _scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (_scrollView.ek_height > _scrollView.contentSize.height) ? ((_scrollView.ek_height - _scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
}

@end
