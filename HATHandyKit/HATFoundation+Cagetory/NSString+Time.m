//
//  NSString+Time.m
//  TBox
//
//  Created by jiangwei9 on 04/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)
+ (instancetype)stringWithCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+ (instancetype)shortStringWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:date];
    return dateTime;
}

+ (NSTimeInterval)getUnixTimeByString:(NSString *)timeString formatString:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd HH:mm:ss"
    [formatter setDateFormat:formatStr];
    return [[formatter dateFromString:timeString] timeIntervalSince1970];
}

+ (NSDate *)getDateByString:(NSString *)timeString formatString:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //@"yyyy-MM-dd HH:mm:ss"
    [formatter setDateFormat:formatStr];
    return [formatter dateFromString:timeString];
}
@end
