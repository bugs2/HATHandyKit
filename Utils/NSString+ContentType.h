//
//  NSString+ContentType.h
//  TBox
//
//  Created by jiangwei9 on 20/02/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ContentType)
- (BOOL)isPhoneNumber;
- (BOOL)is11Number;
- (BOOL)isEmailAddress;
- (BOOL)isValidPassword;
- (BOOL)isValidVerCode;
- (BOOL)isIdentityCardNum;
@end
