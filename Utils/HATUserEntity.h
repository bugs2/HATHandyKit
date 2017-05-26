//
//  HATUserEntity.h
//  TBox
//
//  Created by zhuhuadong on 17/2/17.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 性别 */
typedef NS_ENUM(NSInteger, HATSexState) {
    /** 女 */
    HATSexStateFemale = 0,
    /** 男 */
    HATSexStateMale = 1,
    /** 未知 */
    HATSexStateUnkown = 2
};

@interface HATUserEntity : NSObject <NSCoding>

@property (copy, nonatomic) NSString *contactFamilyName;
@property (copy, nonatomic) NSString *contactGivenName;
@property (copy, nonatomic) NSString *contactFullName;
@property (copy, nonatomic) NSString *contactPhoneNum;

@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *familyName;
@property (copy, nonatomic) NSString *givenName;
@property (copy, nonatomic) NSString *fullName;
@property (copy, nonatomic) NSString *mobileNum;
@property (copy, nonatomic) NSString *cardNum;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *nickName;
@property (readwrite, nonatomic) HATSexState sex;

+ (instancetype)defaultInstance;
- (void)updateUserInfo:(NSDictionary*)userInfo;

@end
