//
//  HATButton.h
//  TBox
//
//  Created by jiangwei9 on 09/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

//整合HYButtonEdgeInsets和小聪聪的AutoMobileButton
//提供UIButton不同状态下背景色，圆角, 图片及标题位置调整功能 如：蓝色背景，圆角，上图下字的button
//依赖#import "UIImage+Common.h"

typedef NS_ENUM(NSUInteger, HYButtonEdgeInsetsStyle) {
    HYButtonEdgeInsetsStyleImageLeft,
    HYButtonEdgeInsetsStyleImageRight,
    HYButtonEdgeInsetsStyleImageTop,
    HYButtonEdgeInsetsStyleImageBottom
};

IB_DESIGNABLE
@interface HATButton : UIButton
#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSUInteger edgeInsetsStyle;
#else
@property (nonatomic) HYButtonEdgeInsetsStyle edgeInsetsStyle;
#endif
@property (nonatomic) IBInspectable CGFloat imageTitleSpace;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

//focused先不支持
@property (nonatomic, assign) IBInspectable UIColor *normalBackgroundColor;
@property (nonatomic, assign) IBInspectable UIColor *highlightedBackgroundColor;
@property (nonatomic, assign) IBInspectable UIColor *selectedBackgroundColor;
@property (nonatomic, assign) IBInspectable UIColor *disabledBackgroundColor;


@end
