//
//  HATPasswordStrengthCalculater.h
//  TBox
//
//  Created by zhuhuadong on 17/3/28.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "define.h"

///密码强度等级
typedef enum
{
    PASS_WORD_RISK = 0,
    PASS_WORD_LOW = 1 ,
    PASS_WORD_MID = 2 ,
    PASS_WORD_STRONG = 3
}PassWordLevelType;

@interface HATPasswordStrengthCalculater : UIView
- (void)setPassWordString:(NSString *)newPassWord;
- (void)setLevel:(PassWordLevelType)level;
@end
