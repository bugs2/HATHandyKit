//
//  HATUserEntity.m
//  TBox
//
//  Created by zhuhuadong on 17/2/17.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATUserEntity.h"

static NSString * const HATContactFamilyName = @"contactFamilyName";
static NSString * const HATContactGivenName = @"contactGivenName";
static NSString * const HATContactFullName = @"contactFullName";
static NSString * const HATContactPhoneNum = @"contactPhoneNum";
static NSString * const HATContactEmail = @"email";
static NSString * const HATSelfFamilyName = @"familyName";
static NSString * const HATSelfGivenName = @"givenName";
static NSString * const HATSelfFullName = @"fullName";
static NSString * const HATSelfMobileNum = @"mobileNum";
static NSString * const HATIDCardNum = @"cardNum";
static NSString * const HATAddress = @"address";
static NSString * const HATSex = @"sex";
static NSString * const HATNickName = @"nickName";

#define isValidStringValue(value) (((value) != nil) && [value isKindOfClass:[NSString class]])
#define isValidNumberValue(value) (((value) != nil) && [value isKindOfClass:[NSNumber class]])


@implementation HATUserEntity

#pragma mark - Public
+ (instancetype)defaultInstance {
    static HATUserEntity *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)updateUserInfo:(NSDictionary*)remoteUserInfo {
    if (remoteUserInfo) {
        self.mobileNum = isValidStringValue(remoteUserInfo[@"mobileNum"])?remoteUserInfo[@"mobileNum"]:@"";
        self.nickName = isValidStringValue(remoteUserInfo[@"nickName"])?remoteUserInfo[@"nickName"]:@"";
        self.email = isValidStringValue(remoteUserInfo[@"email"])?remoteUserInfo[@"email"]:@"";
        self.address = isValidStringValue(remoteUserInfo[@"address"])?remoteUserInfo[@"address"]:@"";
        self.sex = isValidNumberValue(remoteUserInfo[@"sex"])?[remoteUserInfo[@"sex"] integerValue ]:HATSexStateFemale;
        self.fullName = isValidStringValue(remoteUserInfo[@"name"])?remoteUserInfo[@"name"]:@"";
        self.cardNum = isValidStringValue(remoteUserInfo[@"cardNum"])?remoteUserInfo[@"cardNum"]:@"";
        self.contactFullName = isValidStringValue(remoteUserInfo[@"icePerson"])?remoteUserInfo[@"icePerson"]:@"";
        self.contactPhoneNum = isValidStringValue(remoteUserInfo[@"iceNum"])?remoteUserInfo[@"iceNum"]:@"";
    }
}

#pragma mark - NSCopying
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.contactFamilyName forKey:HATContactFamilyName];
    [aCoder encodeObject:self.contactGivenName forKey:HATContactGivenName];
    [aCoder encodeObject:self.contactFullName forKey:HATContactFullName];
    [aCoder encodeObject:self.contactPhoneNum forKey:HATContactPhoneNum];
    [aCoder encodeObject:self.email forKey:HATContactEmail];
    [aCoder encodeObject:self.familyName forKey:HATSelfFamilyName];
    [aCoder encodeObject:self.givenName forKey:HATSelfGivenName];
    [aCoder encodeObject:self.fullName forKey:HATSelfFullName];
    [aCoder encodeObject:self.mobileNum forKey:HATSelfMobileNum];
    [aCoder encodeObject:self.cardNum forKey:HATIDCardNum];
    [aCoder encodeObject:self.address forKey:HATAddress];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.sex] forKey:HATSex];
    [aCoder encodeObject:self.nickName forKey:HATNickName];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.contactFamilyName = kValidStringValue([aDecoder decodeObjectForKey:HATContactFamilyName]);
        self.contactGivenName = kValidStringValue([aDecoder decodeObjectForKey:HATContactGivenName]);
        self.contactFullName = kValidStringValue([aDecoder decodeObjectForKey:HATContactFullName]);
        self.contactPhoneNum = kValidStringValue([aDecoder decodeObjectForKey:HATContactPhoneNum]);
        self.email = kValidStringValue([aDecoder decodeObjectForKey:HATContactEmail]);
        self.familyName = kValidStringValue([aDecoder decodeObjectForKey:HATSelfFamilyName]);
        self.givenName = kValidStringValue([aDecoder decodeObjectForKey:HATSelfGivenName]);
        self.fullName = kValidStringValue([aDecoder decodeObjectForKey:HATSelfFullName]);
        self.mobileNum = kValidStringValue([aDecoder decodeObjectForKey:HATSelfMobileNum]);
        self.cardNum = kValidStringValue([aDecoder decodeObjectForKey:HATIDCardNum]);
        self.address = kValidStringValue([aDecoder decodeObjectForKey:HATAddress]);
        self.sex = [[aDecoder decodeObjectForKey:HATSex] integerValue];
        self.nickName = kValidStringValue([aDecoder decodeObjectForKey:HATNickName]);
    }
    return self;
}

//NSData *stuData = [NSKeyedArchiver archivedDataWithRootObject:stuArray];//归档
//NSLog(@"data = %@",stuData);
//NSArray *stuArray2 =[NSKeyedUnarchiver unarchiveObjectWithData:stuData];//逆归档
//NSLog(@"array2 = %@",stuArray2);

@end
