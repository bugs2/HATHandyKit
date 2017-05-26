//
//  HATPatternLockSubItem.h
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>
/* 图形密码的缩略图(可选择使用) */
@interface HATPatternLockThumbnailView : UIView

/* 绘出图形密码的缩略图 */
- (void)drawResultWithPasswordStringArray:(NSArray*)passwordStringArray fillColor:(UIColor *)fillColor;

@end
