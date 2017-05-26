//
//  UIScrollView+ButtonClick.m
//  TOps
//
//  Created by jiangwei9 on 09/05/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "UIScrollView+ButtonClick.h"

@implementation UIScrollView (ButtonClick)

- (BOOL)delaysContentTouches
{
    return NO;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}
#pragma clang diagnostic pop


@end
