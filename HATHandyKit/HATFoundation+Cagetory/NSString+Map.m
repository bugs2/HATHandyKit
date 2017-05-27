//
//  NSString+Map.m
//  TOps
//
//  Created by jiangwei9 on 08/05/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+Map.h"

@implementation NSString (Map)

/** 经纬度转换成度分秒格式 */
- (NSString *)degreeMinuteSecondStringWithDegreeString {
    /** 将经度或纬度整数部分提取出来 */
    int latNumber = [self intValue];
    
    /** 取出小数点后面两位(为转化成'分'做准备) */
    NSArray *array = [self componentsSeparatedByString:@"."];
    /** 小数点后面部分 */
    NSString *lastCompnetString = [array lastObject];
    
    /** 拼接字字符串(将字符串转化为0.xxxx形式) */
    NSString *str1 = [NSString stringWithFormat:@"0.%@", lastCompnetString];
    
    /** 将字符串转换成float类型以便计算 */
    float minuteNum = [str1 floatValue];
    
    /** 将小数点后数字转化为'分'(minuteNum * 60) */
    float minuteNum1 = minuteNum * 60;
    
    /** 将转化后的float类型转化为字符串类型 */
    NSString *latStr = [NSString stringWithFormat:@"%f", minuteNum1];
    
    /** 取整数部分即为纬度或经度'分' */
    int latMinute = [latStr intValue];
    
    /** 将小数点后数字转化为'秒'(secondNum * 60) */
    float secondNum = [latStr floatValue] - [latStr intValue];
    secondNum = secondNum * 60;
    
    /** 取整数部分即为纬度或经度'秒' */
    int latSecond = (int)secondNum;

    
    /** 将经度或纬度字符串合并为(xx°xx'xx″)形式 */
    NSString *string = [NSString stringWithFormat:@"%d°%d′%d″", latNumber, latMinute, latSecond];
    
    return string;
}

@end
