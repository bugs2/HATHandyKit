//
//  UIViewController+Container.m
//  trycontainController
//
//  Created by jiangwei9 on 28/02/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "UIViewController+Container.h"
#import "ErrorRetryViewController.h"
#import "MyCarsViewController.h"
#import "PersonalInformationViewController.h"

static const NSInteger kNavigationbarHeigh = 20 + 44;
static const NSInteger kTabbarHeigh = 49;


@implementation UIViewController (Container)

#pragma mark - Public
- (void)displayContentController:(UIViewController *)contentVc {
    if (!contentVc) {
        return;
    }
    
    //只显示一个ContentController
    [self hideAllContentController];
    
    //1.添加控制器
    [self addChildViewController:contentVc];
    
    //2.添加view到superview，留出navigatebar的位置
    if (!self.navigationController.isNavigationBarHidden && self.navigationController.navigationBar.isTranslucent) {
        //UIScrollView(主要是TableView)使用Insets，保证与automaticallyAdjustsScrollViewInsets效果相同
        if ([contentVc.view isKindOfClass:[UIScrollView class]]) {
            ((UIScrollView *)contentVc.view).contentInset = UIEdgeInsetsMake(kNavigationbarHeigh, 0, 0, 0);
        } else {
            CGRect frame = self.view.bounds;
            frame.origin.y = kNavigationbarHeigh;
            frame.size.height -= kNavigationbarHeigh;
            contentVc.view.frame = frame;
        }
    }
    
    [self.view addSubview:contentVc.view];
    
    //3.通知vc已经移动到父控制器
    [contentVc didMoveToParentViewController:self];
}

- (void)hideContentController:(UIViewController *)contentVc {
    if (!contentVc) {
        return;
    }
    [contentVc willMoveToParentViewController:nil];
    [contentVc.view removeFromSuperview];
    [contentVc removeFromParentViewController];
}


- (CGRect)contentRect {
    CGRect frame = self.view.bounds;
    //navigation不透明时，系统会自动预留出64高度
    if (!self.navigationController.isNavigationBarHidden && self.navigationController.navigationBar.isTranslucent) {
        frame.size.height -= kNavigationbarHeigh;
    }
    
    if (!self.tabBarController.tabBar.isHidden) {
        frame.size.height -= kTabbarHeigh;
        
        //特殊处理，二级菜单，虽然tabbar看不见，但是仍然在一级菜单存在，不需要减去tabbar高度
        if ([self isMemberOfClass:[MyCarsViewController class]] || [self isMemberOfClass:[PersonalInformationViewController class]]) {
            frame.size.height += kTabbarHeigh;
        }
    }
    
    return frame;
}

#pragma mark - Private
- (void)hideAllContentController {
    NSArray <__kindof UIViewController *> *array = [self childViewControllers];
    for (UIViewController *contentVc in array) {
        [self hideContentController:contentVc];
    }
}

@end
