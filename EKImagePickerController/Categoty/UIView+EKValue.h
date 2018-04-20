//
//  UIView+EKValue.h
//  EKImagePickerView
//
//  Created by lilong on 2018/4/16.
//  Copyright © 2018年 jinding. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RELATIVE_VALUE(x) (x*[[UIScreen mainScreen] bounds].size.width/375)
@interface UIView (EKValue)

@property (nonatomic) CGFloat ek_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat ek_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat ek_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat ek_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat ek_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat ek_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat ek_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat ek_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint ek_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  ek_size;        ///< Shortcut for frame.size.
@end
