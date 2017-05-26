
//
//  HATPatternLockHandler.m
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import "HATPatternLockHandler.h"

#define PATTERNLOCK_KEY  @"PatternLockKey"

@implementation HATPatternLockHandler

#pragma mark - Public
+ (BOOL)isSave {
    NSString *str = [self objectForKey:PATTERNLOCK_KEY];
    if (str && str.length>0 && [str isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isFirstInput:(NSString *)str {
    NSString *oldStr = [self objectForKey:PATTERNLOCK_KEY];
    if (oldStr && oldStr.length > 0 && [oldStr isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    [self setObject:str forKey:PATTERNLOCK_KEY];
    
    return YES;
}

+ (BOOL)isSecondInputRight:(NSString *)str {
    NSString *oldStr = [self objectForKey:PATTERNLOCK_KEY];
    
    if ([oldStr isKindOfClass:[NSNull class]]) {
        return NO;
    } else if (!oldStr || oldStr.length<1 || ![oldStr isKindOfClass:[NSString class]]) {
        return NO;
    } else if (oldStr.length==str.length  &&  [oldStr isEqualToString:str]) {
        return YES;
    }
    
    return NO;
}

+ (void)deletePsw {
    [self removeObjectForKey:PATTERNLOCK_KEY];
}


+ (void)setPSW:(NSString *)str {
    [self setObject:str forKey:PATTERNLOCK_KEY];
}

#pragma mark - Private
+ (void)setObject:(id)object forKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:object forKey:key];
    [userDefault synchronize];
    
//    NSString *path = [NSHomeDirectory() stringByAppendingString:key];
//    BOOL flag = [NSKeyedArchiver archiveRootObject:object toFile:path];
//    if (flag) {
//        NSLog(@"保存成功");
//    } else {
//        NSLog(@"保存失败");
//    }
}

+ (void)removeObjectForKey:(id)key {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
    [userDefault synchronize];
    
//    NSString *path = [NSHomeDirectory() stringByAppendingString:key];
//    NSError *error = nil;
//    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
//    if (!error) {
//        NSLog(@"删除成功");
//    } else {
//        NSLog(@"删除失败");
//    }
}

+ (id)objectForKey:(NSString *)key {
    if (key) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        id object = [userDefault objectForKey:key];
        return object;
        
//        NSString *path = [NSHomeDirectory() stringByAppendingString:key];
//        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
//        return object;
    }
    return nil;
}

@end
