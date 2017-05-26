//
//  HATBiometricAuthentication.m
//  TouchIDDemo
//
//  Created by ZC on 2017/2/14.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import "HATBiometricAuthentication.h"
#import <UIKit/UIKit.h>

@interface HATBiometricAuthentication ()

@property (assign, nonatomic) NSNumber *maxBiometryFailures; // 最大错误次数
@property (copy, nonatomic) NSString *localizedReason;  // 告知用户使用TouchID的原因
@property (assign, nonatomic) BOOL touchIDLockedout;    // TouchID是否被锁定
@property (copy, nonatomic) HATBiometricAuthenticationSuccessBlock biometricAuthenticationSuccessBlock;
@property (copy, nonatomic) HATBiometricAuthenticationFailedBlock biometricAuthenticationFailedBlock;

@end

@implementation HATBiometricAuthentication

- (void)touchIDAuthenticationWithMaxBiometryFailures:(NSNumber *)maxBiometryFailures localizedReason:(NSString *)localizedReason successBlock:(HATBiometricAuthenticationSuccessBlock)successBlock failedBlock:(HATBiometricAuthenticationFailedBlock)failedBlock {
    
    self.biometricAuthenticationSuccessBlock = successBlock;
    
    self.biometricAuthenticationFailedBlock = failedBlock;
    
    self.localizedReason = localizedReason;
    
    // 根据系统版本选择判断机制
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
        
        [self touchIDSetup];
        
    } else {
        
        self.maxBiometryFailures = maxBiometryFailures;
        self.touchIDLockedout = NO;
        [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
        
    }

}

- (void)touchIDSetupWithPolicy:(LAPolicy)policy {
    
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @""; // If set to empty string, the button will be hidden.
    context.maxBiometryFailures = self.maxBiometryFailures; // 8_3, 9_0 默认3次
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:policy error:&error]) {
        
        NSLog(@"支持指纹识别");
        // 开始验证指纹
        [self evaluateWithLAContext:context policy:policy];
        
    } else {
        
        NSLog(@"不支持指纹识别");
        
        /*
         #define kLAErrorAuthenticationFailed                       -1
         #define kLAErrorUserCancel                                 -2
         #define kLAErrorUserFallback                               -3
         #define kLAErrorSystemCancel                               -4
         #define kLAErrorPasscodeNotSet                             -5
         #define kLAErrorTouchIDNotAvailable                        -6
         #define kLAErrorTouchIDNotEnrolled                         -7
         #define kLAErrorTouchIDLockout                             -8
         #define kLAErrorAppCancel                                  -9
         #define kLAErrorInvalidContext                            -10
         */
        
        switch (error.code) {
                
            case LAErrorAuthenticationFailed: {
                NSLog(@"Authentication was not successful, because user failed to provide valid credentials.");
                break;
            }
                
            case LAErrorUserCancel: {
                NSLog(@"Authentication was canceled by user (e.g. tapped Cancel button).");
                break;
            }
                
            case LAErrorUserFallback: {
                NSLog(@"Authentication was canceled, because the user tapped the fallback button (Enter Password).");
                break;
            }
                
            case LAErrorSystemCancel: {
                NSLog(@"Authentication was canceled by system (e.g. another application went to foreground).");
                break;
            }
                
            case LAErrorPasscodeNotSet: {
                // 未设置iPhone解锁密码
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because passcode is not set on the device.");
                break;
            }
                
            case LAErrorTouchIDNotAvailable: {
                // 设备不支持TouchID
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because Touch ID is not available on the device.");
                break;
            }
                
            case LAErrorTouchIDNotEnrolled: {
                // 设备未录入指纹
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because Touch ID has no enrolled fingers.");
                break;
            }
                
            case LAErrorTouchIDLockout: {
                // iOS9
                // 达到系统的指纹输入错误次数上限 TouchID被锁定
                
                // 在这里需要对TouchID进行解锁
                self.touchIDLockedout = YES;
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthentication];
                NSLog(@"there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating");
                break;
            }
                
            case LAErrorAppCancel: {
                // iOS9
                // 授权过程中 App主动取消了验证
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication was canceled by application (e.g. invalidate was called while authentication was in progress).");
                break;
            }
                
            case LAErrorInvalidContext: {
                // iOS9
                // 授权过程中,LAContext对象被释放掉了，造成的授权失败。
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
                NSLog(@"LAContext passed to this call has been previously invalidated.");
                break;
            }
                
            default:{
                NSLog(@"其他问题");
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                break;
            }
                
        }

    }
}

- (void)evaluateWithLAContext:(LAContext *)context policy:(LAPolicy)policy{
    
    NSString *reasion = self.localizedReason;
    //TouchID是否被锁定
    if (self.touchIDLockedout) {
        reasion = NSLocalizedString(@"指纹密码被锁，需要用户输入密码解锁", @"指纹密码被锁，需要用户输入密码解锁");
    }
    [context evaluatePolicy:policy localizedReason:reasion reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            
            NSLog(@"指纹验证成功");
            
            if (self.touchIDLockedout) {
                // TouchID解锁成功
                self.touchIDLockedout = NO;
                // 重新验证指纹
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
                return;
            }
            
            if (self.biometricAuthenticationSuccessBlock) {
                self.biometricAuthenticationSuccessBlock();
            }
            
            return;
        }
        
        switch (error.code) {
                
            case LAErrorAuthenticationFailed: {
                // 达到App设置的指纹输入错误次数上限  或 验证失败
                // 账号密码登录
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication was not successful, because user failed to provide valid credentials.");
                break;
            }
                
            case LAErrorUserCancel: {
                // 账号密码登录
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication was canceled by user (e.g. tapped Cancel button).");
                break;
            }
                
            case LAErrorUserFallback: {
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication was canceled, because the user tapped the fallback button (Enter Password).");
                break;
            }
                
            case LAErrorSystemCancel: {
                // 继续弹出指纹验证
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
                NSLog(@"Authentication was canceled by system (e.g. another application went to foreground).");
                break;
            }
                
            case LAErrorPasscodeNotSet: {
                // 账号密码登录
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because passcode is not set on the device.");
                break;
            }
                
            case LAErrorTouchIDNotAvailable: {
                // 账号密码登录
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because Touch ID is not available on the device.");
                break;
            }
                
            case LAErrorTouchIDNotEnrolled: {
                // 账号密码登录
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication could not start, because Touch ID has no enrolled fingers.");
                break;
            }
                
            case LAErrorTouchIDLockout: {
                // iOS 9
                // 达到系统的指纹输入错误次数上限 TouchID被锁定
                self.touchIDLockedout = YES;
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthentication];
                NSLog(@"there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating");
                break;
            }
                
            case LAErrorAppCancel: {
                // iOS9
                // 授权过程中 App主动取消了验证
                if (self.biometricAuthenticationFailedBlock) {
                    self.biometricAuthenticationFailedBlock(error);
                }
                NSLog(@"Authentication was canceled by application (e.g. invalidate was called while authentication was in progress).");
                break;
            }
                
            case LAErrorInvalidContext: {
                // iOS9
                // 授权过程中,LAContext对象被释放掉了，造成的授权失败。
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
                NSLog(@"LAContext passed to this call has been previously invalidated.");
                break;
            }
                
            default:{
                NSLog(@"其他问题");
                [self touchIDSetupWithPolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics];
                break;
            }
   
        }
    }];
}

- (void)touchIDSetup NS_ENUM_AVAILABLE(8_4, 8_0) {
    LAContext  *context= [[LAContext alloc] init];
    context.localizedFallbackTitle = @"";
    NSError *error;
    /*
     LAPolicyDeviceOwnerAuthenticationWithBiometrics iOS8
     LAPolicyDeviceOwnerAuthentication               iOS9
     */
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [self evaluateWithLAContext:context];
        
    } else {
        NSLog(@"不支持指纹识别");
        if (self.biometricAuthenticationFailedBlock) {
            self.biometricAuthenticationFailedBlock(error);
        }
    }
}

- (void)evaluateWithLAContext:(LAContext *)context NS_ENUM_AVAILABLE(8_4, 8_0){
    NSLog(@"支持指纹识别");
    
    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:self.localizedReason reply:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            
            NSLog(@"指纹验证成功");
            if (self.biometricAuthenticationSuccessBlock) {
                self.biometricAuthenticationSuccessBlock();
            }
            
        } else {
            
            /*
             #define kLAErrorAuthenticationFailed                       -1
             #define kLAErrorUserCancel                                 -2
             #define kLAErrorUserFallback                               -3
             #define kLAErrorSystemCancel                               -4
             #define kLAErrorPasscodeNotSet                             -5
             #define kLAErrorTouchIDNotAvailable                        -6
             #define kLAErrorTouchIDNotEnrolled                         -7
             #define kLAErrorTouchIDLockout                             -8
             #define kLAErrorAppCancel                                  -9
             #define kLAErrorInvalidContext                            -10
             */
            
            switch (error.code) {
                case -1:{
                    
                    if ([[NSString stringWithFormat:@"%@", error] rangeOfString:@"Aplication retry limit exceeded"].location != NSNotFound) {
                        NSLog(@"指纹识别达到单次验证上限（3次)");
                        /* 达到单次验证上限（3次）
                         Error Domain=com.apple.LocalAuthentication Code=-1 "Aplication retry limit exceeded." UserInfo=0x174275540 {NSLocalizedDescription=Aplication retry limit exceeded.}
                         */
                        if (self.biometricAuthenticationFailedBlock) {
                            self.biometricAuthenticationFailedBlock(error);
                        }
                    }
                    
                    if ([[NSString stringWithFormat:@"%@", error] rangeOfString:@"Biometry is locked out"].location != NSNotFound) {
                        NSLog(@"指纹识别达到系统错误上限");
                        /* 达到系统错误上限
                         Error Domain=com.apple.LocalAuthentication Code=-1 "Biometry is locked out." UserInfo=0x170263500 {NSLocalizedDescription=Biometry is locked out.}
                         */
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self touchIDSetup];
                        });
                    }
                    
                    break;
                }
                    
                case -2:{
                    NSLog(@"点击了取消按钮");
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
                    
                case -3:{
                    NSLog(@"点输入密码按钮");
                    break;
                }
                    
                case -4:{
                    NSLog(@"按下电源键");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self touchIDSetup];
                    });
                    break;
                }
                    
                case -5:{
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
                    
                case -6:{
                    NSLog(@"设备不支持");
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
                    
                case -7:{
                    NSLog(@"指纹未录入");
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
                    
                case -8:{
                    NSLog(@"Touch ID功能被锁定，下一次需要输入系统密码");
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
                    
                default:{
                    NSLog(@"其他问题");
                    if (self.biometricAuthenticationFailedBlock) {
                        self.biometricAuthenticationFailedBlock(error);
                    }
                    break;
                }
            }
            
        }
    }];
}

@end
