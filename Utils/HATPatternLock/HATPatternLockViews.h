//
//  HATPatternLockViews.h
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HATPatternLockViewsModeSet,             // 设置图形密码
    HATPatternLockViewsModeModify,          // 修改图形密码
    HATPatternLockViewsModeVerification,    // 验证图形密码
    HATPatternLockViewsModeDelete,          // 删除图形密码
    HATPatternLockViewsModeNone,            // 缺省
} HATPatternLockViewsMode;  // 图形密码使用模式

typedef void(^HATPatternLockSuccessBlock)(HATPatternLockViewsMode patternLockViewsMode);
typedef void(^HATPatternLockFailureBlock)(HATPatternLockViewsMode patternLockViewsMode);
typedef void(^HATPatternLockCancelBlock)();

@interface HATPatternLockViews : UIView

@property (assign, nonatomic) HATPatternLockViewsMode patternLockViewsMode;

@property (copy, nonatomic) HATPatternLockSuccessBlock successBlock;
@property (copy, nonatomic) HATPatternLockFailureBlock failureBlock;
@property (copy, nonatomic) HATPatternLockCancelBlock  cancelBlock;

@property (assign, nonatomic) BOOL shouldThumbnailViewHidden; // 是否显示顶部缩略图
@property (assign, nonatomic) BOOL showDirection;             // 是否显示连线方向

- (instancetype)initWithFrame:(CGRect)frame mode:(HATPatternLockViewsMode)patternLockViewsMode;
- (void)showMessage:(NSString *)message shouldAlert:(BOOL)shouldAlert;

@end
