//
//  HATPatternLockHandler.h
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HATPatternLockHandler : NSObject

/****** 是否是第一次输入 ******/
+ (BOOL)isFirstInput:(NSString *)str;

/****** 判断第二次输入 ******/
+ (BOOL)isSecondInputRight:(NSString *)str;

/****** 删除密码 ******/
+ (void)deletePsw;

/****** 设置密码 ******/
+ (void)setPSW:(NSString *)str;

/***** 是否有保存记录 ******/
+ (BOOL)isSave;

@end
