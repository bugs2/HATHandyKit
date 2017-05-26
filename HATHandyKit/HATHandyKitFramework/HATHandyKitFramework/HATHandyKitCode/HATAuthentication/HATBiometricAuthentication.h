//
//  HATBiometricAuthentication.h
//  TouchIDDemo
//
//  Created by ZC on 2017/2/14.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

/* 生物特征身份认证（Biometric authentication）*/

typedef void(^HATBiometricAuthenticationSuccessBlock)();
typedef void(^HATBiometricAuthenticationFailedBlock)(NSError *error);

@interface HATBiometricAuthentication : NSObject

/// 调用该方法使用TouchID验证用户身份
/// @discussion 该方法返回验证成功或失败。内部包含了TouchID的解锁流程（当输错次数达到系统上限需要解锁TouchID后才可以使用），解锁后刷新本轮最大验证失败次数（maxBiometryFailures）。
/// @param maxBiometryFailures 本轮验证最大错误次数
/// @param localizedReason Application reason for authentication. This string must be provided in correct localization and should be short and clear. It will be eventually displayed in the authentication dialog. A name of the calling application will be already displayed in title, so it should not be duplicated here.
/// @param successBlock 验证成功的回调
/// @param failedBlock 验证失败的回调
/// @see LAContext
- (void)touchIDAuthenticationWithMaxBiometryFailures:(NSNumber *)maxBiometryFailures localizedReason:(NSString *)localizedReason successBlock:(HATBiometricAuthenticationSuccessBlock)successBlock failedBlock:(HATBiometricAuthenticationFailedBlock)failedBlock;

@end
