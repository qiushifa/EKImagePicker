//
//  UIView+EKValue.m
//  EKImagePickerView
//
//  Created by lilong on 2018/4/16.
//  Copyright © 2018年 jinding. All rights reserved.
//

#import "UIView+EKValue.h"

@implementation UIView (EKValue)

- (CGFloat)ek_left {
    return self.frame.origin.x;
}

- (void)setEk_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ek_top {
    return self.frame.origin.y;
}

- (void)setEk_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)ek_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setEk_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ek_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEk_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ek_width {
    return self.frame.size.width;
}

- (void)setEk_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ek_height {
    return self.frame.size.height;
}

- (void)setEk_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ek_centerX {
    return self.center.x;
}

- (void)setEk_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)ek_centerY {
    return self.center.y;
}

- (void)setEk_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)ek_origin {
    return self.frame.origin;
}

- (void)setEk_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)ek_size {
    return self.frame.size;
}

- (void)setEk_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
