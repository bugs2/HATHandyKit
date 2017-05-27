//
//  NSString+Replace.h
//  TBox
//
//  Created by ZC on 2017/2/20.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Replace)

/* 将一段字符串中指定位置的字符替换成需要的字符，shouldRepeat决定是否重复replacingString，重复的次数是range.length
    例如18866668888->188****8888
 */
- (NSString *)replaceWithReplacingString:(NSString *)replacingString atRange:(NSRange)range shouldRepeat:(BOOL)shouldRepeat;

@end
