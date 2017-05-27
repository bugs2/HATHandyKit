//
//  NSString+Sha256.m
//  trysha256
//
//  Created by jiangwei9 on 20/02/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "NSString+Sha256.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (Sha256)

// 散列函数--sha256对字符串加密
- (NSString*)sha256 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
