//
//  UIView+AddGradient.m
//  TOps
//
//  Created by jiangwei9 on 04/05/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "UIView+AddGradient.h"
#import "UIColor+expanded.h"

const NSInteger kGradientHeight = 5;
NSString * const kTopGradientColor = @"0x6987b2";
NSString * const kBottomGradientColor = @"0x6987b2";

@implementation UIView (AddGradient)

- (void)showGradientOnTop:(BOOL)show {
    CAGradientLayer *gradientLayer = self.topGradient;
    if (!show) {
        [gradientLayer removeFromSuperlayer];
        return;
    }
    
    if (gradientLayer == nil) {
        gradientLayer = [self aTopGradientLayer];
        CGRect rect = gradientLayer.frame;
        rect.origin.y = 0;
        gradientLayer.frame = rect;
        self.topGradient = gradientLayer;
    }
    [self.layer addSublayer:self.topGradient];
}

- (void)showGradientOnLeft:(BOOL)show {
    //暂不实现
}

- (void)showGradientOnDown:(BOOL)show {
    CAGradientLayer *gradientLayer = self.downGradient;
    if (!show) {
        [gradientLayer removeFromSuperlayer];
        return;
    }
    
    if (gradientLayer == nil) {
        gradientLayer = [self aBottomGradientLayer];
        CGRect rect = gradientLayer.frame;
        rect.origin.y = self.height - kGradientHeight;
        gradientLayer.frame = rect;
        self.downGradient = gradientLayer;
    }
    [self.layer addSublayer:self.downGradient];
}

- (void)showGradientOnRight:(BOOL)show {
    //暂不实现
}

#pragma mark - Private
- (CAGradientLayer *)aTopGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.width, kGradientHeight);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    gradientLayer.colors = @[
                             (__bridge id)[[UIColor colorWithHexString:kTopGradientColor] colorWithAlphaComponent:0.0].CGColor,
                             (__bridge id)[[UIColor colorWithHexString:kBottomGradientColor] colorWithAlphaComponent:0.2].CGColor
                             ];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[ @(0.0f), @(1.0f) ];
//    gradientLayer.borderWidth = 1;

    
    return gradientLayer;
}

- (CAGradientLayer *)aBottomGradientLayer {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.width, kGradientHeight);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    //设置颜色数组
    gradientLayer.colors = @[
                                 (__bridge id)[[UIColor colorWithHexString:kTopGradientColor] colorWithAlphaComponent:0.2].CGColor,
                                 (__bridge id)[[UIColor colorWithHexString:kBottomGradientColor] colorWithAlphaComponent:0].CGColor
                                 ];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[ @(0.0f), @(1.0f) ];
//    gradientLayer.borderWidth = 1;

    
    return gradientLayer;
}

#pragma mark - Setter & Getter
- (void)setTopGradient:(CAGradientLayer *)layer {
    objc_setAssociatedObject(self, @selector(topGradient), layer, OBJC_ASSOCIATION_ASSIGN);
}

- (CAGradientLayer *)topGradient {
    return objc_getAssociatedObject(self, @selector(topGradient));
}

- (void)setDownGradient:(CAGradientLayer *)layer {
    objc_setAssociatedObject(self, @selector(downGradient), layer, OBJC_ASSOCIATION_ASSIGN);
}

- (CAGradientLayer *)downGradient {
    return objc_getAssociatedObject(self, @selector(downGradient));
}


@end
