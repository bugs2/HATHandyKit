//
//  UIViewController+BackButtonHandler.h
//  TBox
//
//  Created by zhuhuadong on 17/3/27.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>

@end
