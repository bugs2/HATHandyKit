//
//  InteractionMaster.m
//  TaiYing
//
//  Created by ZC on 16/6/3.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

#import "InteractionMaster.h"
#import "AppDelegate.h"
#import "LoadingImageView.h"
#import "MGPopController.h"

@implementation InteractionMaster

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(id)viewController confirmButtonTitle:(NSString *)confirmButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle confirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock {
//    if (![viewController isKindOfClass:[UIViewController class]]) {
//        NSLog(@"InterationMaster:CALLER IS NOT A ViewController");
//        return;
//    }
    
    /*
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        // 8.0以上的系统
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            if (confirmActionBlock != nil) {
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    confirmActionBlock();
                }];
                [alert addAction:confirmAction];
            }
            if (cancelActionBlock != nil) {
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    cancelActionBlock();
                }];
                [alert addAction:cancelAction];
            }
            
            alert.view.tintColor = kColorThemeBlue;
            
            [(UIViewController *)viewController presentViewController:alert animated:YES completion:nil];
            
            // Necessary to apply tint above iOS 9
            alert.view.tintColor = kColorThemeBlue;
        });
        
    } else {
        // 8.0以下的系统
        dispatch_async(dispatch_get_main_queue(), ^{
            
            InteractionDelegate *interactionDelegate = [[InteractionDelegate alloc] initWithConfirmActionBlock:confirmActionBlock cancelActionBlock:cancelActionBlock];
            
            if (interactionDelegate == nil) {
                NSLog(@"interactionDelegate is nil");
                return;
            }
            
            UIAlertView*alert = [[UIAlertView alloc]initWithTitle:title
                                                          message:message
                                                         delegate:interactionDelegate
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil];
            
            if (confirmActionBlock != nil) {
                [alert addButtonWithTitle:confirmButtonTitle];
            }
            
            if (cancelActionBlock != nil) {
                [alert addButtonWithTitle:cancelButtonTitle];
            }
            
            [[UIView appearanceWhenContainedIn:[UIAlertView class], nil] setTintColor:[UIColor orangeColor]];
            
            [alert show];
        });
    }*/
    
    
    
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
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self alertWithTitle:title message:message viewController:appDelegate.window.rootViewController confirmButtonTitle:confirmButtonTitle cancelButtonTitle:nil confirmActionBlock:confirmActionBlock cancelActionBlock:nil];
}

+ (void)toastWithMode:(MBProgressHUDMode)mode dimBackground:(BOOL)dimBackground text:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
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
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:appDelegate.window animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:14];
        hud.margin = kMessageView_TopMargin;
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
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:appDelegate.window animated:NO];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:14];
        //hud.bezelView.backgroundColor = kColorToastColor;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = kColorToastColor;
        hud.bezelView.layer.cornerRadius = kMessageView_Corneradios;
        hud.margin = kMessageView_TopMargin;
        [hud hideAnimated:YES afterDelay:delayTime];
    });
}

+ (void)toastCautionInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.label.numberOfLines = 0;
        hud.label.font = [UIFont boldSystemFontOfSize:14];
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
/*
 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
 hud.mode = MBProgressHUDModeCustomView;
 LoadingImageView *loadingImageView = [[LoadingImageView alloc] initWithImage:[UIImage imageNamed:@"加载_1"]];
 [loadingImageView startAnimate];
 hud.customView = loadingImageView;
 hud.contentColor = [UIColor whiteColor];
 hud.label.text = @"正在获取设备信息...";
 hud.label.numberOfLines = 0;
 hud.bezelView.backgroundColor = kColorToastColor;
 */

/*
+ (void)actionSheetWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonColor:(UIColor *)cencelButtonColor destructiveButtonTitle:(NSString *)destructiveButtonTitle destructiveButtonColor:(UIColor *)destructiveButtonColor actionSheetSelectionBlock:(ActionSheetSelectionBlock)block otherButtonTitles:(NSString *)otherButtonTitles, ... {
 
    InteractionDelegate *interactionDelegate = [[InteractionDelegate alloc] initWithActionSheetSelectionBlock:block];
    
    va_list argList;
    va_start(argList, otherButtonTitles);
    TBActionSheet *actionSheet = [[TBActionSheet alloc] initWithTitle:title delegate:interactionDelegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, argList, nil];
    va_end(argList);
    actionSheet.message = message;
    [TBActionSheet appearance].rectCornerRadius = 0;
    [TBActionSheet appearance].sheetWidth = kScreenWidth;
    [TBActionSheet appearance].buttonHeight = 45;
    [TBActionSheet appearance].offsetY = 0;
    [TBActionSheet appearance].buttonFont = [UIFont systemFontOfSize:14];
    [TBActionSheet appearance].tintColor = [UIColor whiteColor];
    [TBActionSheet appearance].cancelButtonColor = cencelButtonColor;
    [TBActionSheet appearance].destructiveButtonColor = destructiveButtonColor;
    [TBActionSheet appearance].backgroundTransparentEnabled = NO;
    [TBActionSheet appearance].blurEffectEnabled = YES;
    [TBActionSheet appearance].ambientColor = [UIColor colorWithRed:37/255.0 green:41/255.0 blue:42/255.0 alpha:1];
    [TBActionSheet appearance].separatorColor = [UIColor blackColor];
    
    [actionSheet show];
    
}
 */

@end
