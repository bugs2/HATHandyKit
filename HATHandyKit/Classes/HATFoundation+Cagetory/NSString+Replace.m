//
//  NSString+Replace.m
//  TBox
//
//  Created by ZC on 2017/2/20.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)

- (NSString *)replaceWithReplacingString:(NSString *)replacingString atRange:(NSRange)range shouldRepeat:(BOOL)shouldRepeat {
    
    NSString *stringNeedToBeReplace = [self substringWithRange:range];
    NSString *replacedString = @"";
    NSString *fianlReplacingString = @"";
    if (shouldRepeat) {
        for (int i = 0; i < range.length; i ++) {
            fianlReplacingString = [fianlReplacingString stringByAppendingString:replacingString];
        }
    } else {
        fianlReplacingString = replacingString;
    }
    
    replacedString = [self stringByReplacingOccurrencesOfString:stringNeedToBeReplace withString:fianlReplacingString];
    
    return replacedString;
}

@end
