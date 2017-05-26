//
//  HATPatternLockItem.h
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HATPatternLockItemStyleNormal,      // 普通显示的效果
    HATPatternLockItemStyleSelected,    // 选中时的效果
    HATPatternLockItemStyleWrong,       // 错误的效果
} HATPatternLockItemStyle;

@interface HATPatternLockItem : UIView

@property (assign, nonatomic) HATPatternLockItemStyle itemStyle;

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) UIColor *fillColor; // 内部填充色的颜色
@property (strong, nonatomic) UIColor *selectedColor; // 选中时中心点的颜色
@property (strong, nonatomic) UIColor *triangleLayerColor; // 方向指针的颜色

/* 绘出手势的方向 */
- (void)showDirectionWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint shouldHidden:(BOOL)shouldHidden;

@end
