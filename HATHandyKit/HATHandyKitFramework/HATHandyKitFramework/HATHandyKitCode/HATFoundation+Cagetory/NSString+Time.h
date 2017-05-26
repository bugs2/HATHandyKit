//
//  NSString+Time.h
//  TBox
//
//  Created by jiangwei9 on 04/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

+ (instancetype)stringWithCurrentTime;
+ (instancetype)shortStringWithDate:(NSDate *)date;
+ (NSTimeInterval)getUnixTimeByString:(NSString *)timeString formatString:(NSString *)formatStr;
+ (NSDate *)getDateByString:(NSString *)timeString formatString:(NSString *)formatStr;

@end
