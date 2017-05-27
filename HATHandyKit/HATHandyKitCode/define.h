//
//  Header.h
//  HATHandyKitFramework
//
//  Created by jiangwei9 on 26/05/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "UIColor+expanded.h"
#import "UIImage+Common.h"
#import "UIView+Additions.h"
#import "UIView+AddGradient.h"

#import "InteractionMaster.h"
#import "MJRefresh.h"

#import "YTKBaseRequest+AnimatingAccessory.h"

#pragma mark - window
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#pragma mark - iphone
#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))


#pragma mark - color
#define kColor222 [UIColor colorWithHexString:@"0x222222"]
#define kColor333 [UIColor colorWithHexString:@"0x333333"]
#define kColor666 [UIColor colorWithHexString:@"0x666666"]
#define kColor999 [UIColor colorWithHexString:@"0x999999"]
#define kColorDDD [UIColor colorWithHexString:@"0xDDDDDD"]
#define kColorCCC [UIColor colorWithHexString:@"0xCCCCCC"]
#define kColorTransparent333 [[UIColor colorWithHexString:@"0x333333"] colorWithAlphaComponent:0.8];

#pragma mark - toast & alarm
#define kColorToastColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.8]
#define kMessageView_TopMargin 9
#define kMessageView_LeftMargin 22
#define kMessageView_Corneradios 18
#define kAlertView_Corneradios 7

#pragma mark - Weak & Strong
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#endif /* Header_h */
