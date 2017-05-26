//
//  NSNumber+TimeString.m
//  TBox
//
//  Created by jiangwei9 on 03/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSNumber+TimeString.h"

@implementation NSNumber (TimeString)
- (NSString *)YYYYMMDDString {
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:[self unsignedIntegerValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    return na;
}

- (NSString *)YYYYString {
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:[self unsignedIntegerValue]];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy"];
    NSString * na = [df stringFromDate:currentDate];
    return na;
}


@end
