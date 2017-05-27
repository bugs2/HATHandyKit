//
//  InteractionMaster.m
//  TaiYing
//
//  Created by ZC on 16/6/3.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

#import "InteractionMaster.h"
#import "LoadingImageView.h"
#import "MGPopController.h"
#import "MBProgressHUD.h"
#import "define.h"

@implementation HACMBProgressHUD

- (void)setLeftMargin:(CGFloat)margin {
    if (margin != _leftMargin) {
        _leftMargin = margin;
        [self setNeedsUpdateConstraints];
    }
}

- (void)updateConstraints {
    [super updateConstraints];
    
    
    for (NSLayoutConstraint *constrant in self.bezelView.constraints) {
        NSLayoutAttribute attribute1 = constrant.firstAttribute;
        NSLayoutAttribute attribute2 = constrant.secondAttribute;
        
        if ((attribute1 == attribute2) && (attribute1 == NSLayoutAttributeLeading || attribute1 == NSLayoutAttributeTrailing)) {
            constrant.constant = self.leftMargin;
        }
    }
}

@end


@implementation InteractionMaster

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(id)viewController confirmButtonTitle:(NSString *)confirmButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle confirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock {
    
    MGPopController *pop = [[MGPopController alloc] initWithTitle:title message:message image:nil];
    

    if (cancelActionBlock != nil) {
        [pop addAction:[MGPopAction actionWithTitle:cancelButtonTitle action:^{
            cancelActionBlock();
        }]];
    }
    
    if (confirmActionBlock != nil) {
        [pop addAction:[MGPopAction actionWithTitle:confirmButtonTitle action:^{
            confirmActionBlock();
        }]];
    }
    
    pop.titleFont = [UIFont boldSystemFontOfSize:16.0f];
    pop.messageFont = [UIFont boldSystemFontOfSize:16.0];
    pop.showActionSeparator = YES;
    pop.actionSpacing = 0;
    pop.actionPaddingLeftRight = 0;
    pop.actionPaddingBottom = 0;
    pop.showCloseButton = NO;
    
    [pop show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(id)viewController confirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock {
    
    [self alertWithTitle:title message:message viewController:viewController confirmButtonTitle:NSLocalizedString(@"确定", @"确定") cancelButtonTitle:NSLocalizedString(@"取消", @"取消") confirmActionBlock:confirmActionBlock cancelActionBlock:cancelActionBlock];
    
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmButtonTitle confirmActionBlock:(ConfirmActionBlock)confirmActionBlock {
    [self alertWithTitle:title message:message viewController:[UIApplication sharedApplication].delegate.window.rootViewController confirmButtonTitle:confirmButtonTitle cancelButtonTitle:nil confirmActionBlock:confirmActionBlock cancelActionBlock:nil];
}

+ (void)toastWithMode:(MBProgressHUDMode)mode dimBackground:(BOOL)dimBackground text:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.mode = mode;
        hud.label.text = text;
        hud.label.font = [UIFont boldSystemFontOfSize:14];

        //hud.bezelView.backgroundColor = kColorToastColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = kColorToastColor;
        hud.contentColor = [UIColor whiteColor];
        hud.label.numberOfLines = 0;
        [hud hideAnimated:YES afterDelay:delayTime];
    });
}

/**
 *  Toast Error info
 *
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastErrorInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.window animated:NO];
        HACMBProgressHUD *hud = [HACMBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.offset = CGPointMake(0.f, kScreen_Height * 0.1);
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:15];
        hud.margin = kMessageView_TopMargin;
        hud.leftMargin = kMessageView_LeftMargin;
        hud.bezelView.layer.cornerRadius = kMessageView_Corneradios;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        //hud.bezelView.backgroundColor = kColorToastColor;
        hud.bezelView.color = kColorToastColor;
        [hud hideAnimated:YES afterDelay:delayTime];
    });
}

/**
 *  Toast Success Info
 *
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastSuccessInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window.window animated:NO];
        HACMBProgressHUD *hud = [HACMBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.offset = CGPointMake(0.f, kScreen_Height * 0.1);
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:15];
        //hud.bezelView.backgroundColor = kColorToastColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = kColorToastColor;
        hud.bezelView.layer.cornerRadius = kMessageView_Corneradios;
        hud.margin = kMessageView_TopMargin;
        hud.leftMargin = kMessageView_LeftMargin;
        [hud hideAnimated:YES afterDelay:delayTime];
    });
}

+ (void)toastCautionInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:15];
       // hud.bezelView.backgroundColor = kColorToastColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = kColorToastColor;
        hud.bezelView.layer.cornerRadius = kMessageView_Corneradios;
        hud.margin = kMessageView_TopMargin;
        [hud hideAnimated:YES afterDelay:delayTime];
    });
}

/**
 *  Get a custom loading MBProgressHUD
 *
 *  @param view          view hud will add to
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (MBProgressHUD *)showCustomLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text autoHidenDelayTime:(NSTimeInterval)delayTime {
    __block MBProgressHUD *hud;
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    LoadingImageView *loadingImageView = [[LoadingImageView alloc] initWithImage:[UIImage imageNamed:@"加载_1"]];
    [loadingImageView startAnimate];
    hud.customView = loadingImageView;
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont boldSystemFontOfSize:14];
    //hud.bezelView.backgroundColor = kColorToastColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = kColorToastColor;
    
    delayTime > 0 ? [hud hideAnimated:YES afterDelay:delayTime] : nil;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        
//    });
    
    return hud;
}

/**
 *  Get a HUDCustom SuccessView
 *
 * return a HUDCustom SuccessView
 */
+ (UIImageView *)aHUDCustomSuccessView {
    UIImageView *successImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"正确"]];
    return successImageView;
}

/**
 *  Get a HUDCustom ErrorView
 *
 * return a HUDCustom ErrorView
 */
+ (UIImageView *)aHUDCustomErrorView {
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"错误"]];
    return errorImageView;
}

/**
 *  Get a HUDCustom CautionView
 *
 * return a HUDCustom CautionView
 */
+ (UIImageView *)aHUDCustomCautionView {
    UIImageView *cautionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"注意"]];
    return cautionImageView;
}

@end
