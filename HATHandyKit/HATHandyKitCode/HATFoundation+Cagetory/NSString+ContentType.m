//
//  NSString+ContentType.m
//  TBox
//
//  Created by jiangwei9 on 20/02/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+ContentType.h"
#pragma mark - Public
@implementation NSString (ContentType)
- (BOOL)is11Number {
    //单纯验证11位数字
    NSString *regex = @"^\\d{11}";
    return [self isValidateByRegex:regex];
}

- (BOOL)isPhoneNumber {
    NSString *regex = @"^1[3|4|5|7|8]\\d{9}";
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidAccount {
    NSString *regex = @"^.{1,16}";
    return [self isValidateByRegex:regex];
}

- (BOOL)isEmailAddress {
    //NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,4}";
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

- (BOOL)isValidPassword {
    NSString *regex = @"[a-zA-Z0-9]{8,16}";
    return [self isValidateByRegex:regex];
}

- (BOOL)isValidVerCode {
    NSString *regex = @"[a-zA-Z0-9]{4}";
    return [self isValidateByRegex:regex];
}

- (BOOL)isIdentityCardNum {
    NSString *regex = @"^(\\\\d{14}|\\\\d{17})(\\\\d|[xX])$";
    return [self isValidateByRegex:regex];
}

#pragma mark - Private
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

@end
