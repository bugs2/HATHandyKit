//
//  InteractionMaster.h
//  TaiYing
//
//  Created by ZC on 16/6/3.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractionDelegate.h"
#import "MBProgressHUD.h"

typedef void(^ConfirmActionBlock)();
typedef void(^CancelActionBlock)();

typedef void(^ActionSheetSelectionBlock)(NSInteger buttonIndex);

@interface InteractionMaster : NSObject

@property (nonatomic, copy)ConfirmActionBlock confirmActionBlock;
@property (nonatomic, copy)CancelActionBlock cancelActionBlock;

@property (nonatomic, copy)ActionSheetSelectionBlock actionSheetSelectionBlock;

/**
 *  Pop an AlertView
 *
 *  @param title              alert title
 *  @param message            alert message
 *  @param viewController     viewController of caller
 *  @param confirmButtonTitle confirm button's title
 *  @param cancelButtonTitle  cancel button's title
 *  @param confirmActionBlock confirmAction callback
 *  @param cancelActionBlock  cancelAction callback
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(id)viewController confirmButtonTitle:(NSString *)confirmButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle confirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock;

/**
 *  Pop an AlertView
 *
 *  @param title              alert title
 *  @param message            alert message
 *  @param viewController     viewController of caller
 *  @param confirmActionBlock confirmAction callBack
 *  @param cancelActionBlock  cancelAction callBack
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message viewController:(id)viewController confirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock;
/**
 *  Pop an AlertView
 *
 *  @param title              alert title
 *  @param message            alert message
 *  @param confirmButtonTitle confirm button's title
 *  @param confirmActionBlock confirmAction callback
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message confirmButtonTitle:(NSString *)confirmButtonTitle confirmActionBlock:(ConfirmActionBlock)confirmActionBlock;

/**
 *  Toast
 *
 *  @param mode          MBProgressHUDMode
 *  @param dimBackground dimBackground
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastWithMode:(MBProgressHUDMode)mode dimBackground:(BOOL)dimBackground text:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime;

/**
 *  Toast Error info
 *
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastErrorInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime;

/**
 *  Toast Success Info
 *
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastSuccessInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime;

/**
 *  Toast Caution Info
 *
 *  @param text          text
 *  @param delayTime     delayTime
 */
+ (void)toastCautionInfoWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delayTime;

/**
 *  Get a custom loading MBProgressHUD
 *
 *  @param view          view hud will add to
 *  @param text          text
 *  @param delayTime     delayTime
 *  @return              MBProgressHUD
 */
+ (MBProgressHUD *)showCustomLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text autoHidenDelayTime:(NSTimeInterval)delayTime;

/**
 *  Get a HUDCustom SuccessView
 *
 *  return a HUDCustom SuccessView
 */
+ (UIImageView *)aHUDCustomSuccessView;

/**
 *  Get a HUDCustom ErrorView
 *
 *  return a HUDCustom ErrorView
 */
+ (UIImageView *)aHUDCustomErrorView;

/**
 *  Get a HUDCustom CautionView
 *
 *  return a HUDCustom CautionView
 */
+ (UIImageView *)aHUDCustomCautionView;

/**
 *  Custom ActionSheet
 *
 *  @param title                  title
 *  @param message                message
 *  @param cancelButtonTitle      cancel Button Title
 *  @param cencelButtonColor      cencel Button Color
 *  @param distructiveButtonTitle distructive Button Title
 *  @param distructiveButtonColor distructive Button Color
 *  @param block                  action sheet selection block
 *  @param otherButtonTitles      other Button Titles
 */
/*
+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)message
           cancelButtonTitle:(NSString *)cancelButtonTitle
           cancelButtonColor:(UIColor *)cencelButtonColor
      destructiveButtonTitle:(NSString *)destructiveButtonTitle
      destructiveButtonColor:(UIColor *)destructiveButtonColor
   actionSheetSelectionBlock:(ActionSheetSelectionBlock)block
           otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
*/
@end
