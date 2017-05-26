//
//  UIViewController+Container.h
//  trycontainController
//
//  Created by jiangwei9 on 28/02/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Container)

- (void)displayContentController:(UIViewController *)contentVc;
- (void)hideContentController:(UIViewController *)contentVc;

// 去除status navigation及Tabbar以后的区域
- (CGRect)contentRect;
@end
