//
//  NSString+Secret.m
//  TBox
//
//  Created by jiangwei9 on 09/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+Secret.h"

@implementation NSString (Secret)
- (NSString *)secretName {
    NSString *str = [self copy];
    NSUInteger strLen = str.length;
    //一个字不做限制
    if (strLen < 2) {
        return self;
    }
    //两个字替换后面一个
    if (strLen == 2) {
        return [str stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
    }
    //三个字及以上，替换除中间字符
    NSString *secretName = [@"" stringByPaddingToLength:strLen - 2 withString:@"*" startingAtIndex:0];
    return [self stringByReplacingCharactersInRange:NSMakeRange(1, strLen - 2) withString:secretName];
}

- (NSString *)secretMoblieNum {
    NSString *str = [self copy];
    
    return [str stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
}

@end
