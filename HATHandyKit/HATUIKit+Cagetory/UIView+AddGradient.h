//
//  UIView+AddGradient.h
//  TOps
//
//  Created by jiangwei9 on 04/05/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+Additions.h"
#import <objc/runtime.h>


@interface UIView (AddGradient)

- (void)showGradientOnTop:(BOOL)show;
- (void)showGradientOnLeft:(BOOL)show;
- (void)showGradientOnDown:(BOOL)show;
- (void)showGradientOnRight:(BOOL)show;

@end
