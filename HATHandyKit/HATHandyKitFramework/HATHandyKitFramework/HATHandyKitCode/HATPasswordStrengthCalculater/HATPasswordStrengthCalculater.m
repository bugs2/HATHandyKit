//
//  HATPasswordStrengthCalculater.m
//  TBox
//
//  Created by zhuhuadong on 17/3/28.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATPasswordStrengthCalculater.h"
#import <Masonry/Masonry.h>

#define kColorPwdImgStrongLevel [UIColor colorWithHexString:@"0x19CC72"]
#define kColorPwdLabelStrongLevel [UIColor colorWithHexString:@"0x0EA50E"]
#define kColorPwdLabelMidLevel [UIColor colorWithHexString:@"0xF28A00"]
#define kColorPwdLabelLowLevel [UIColor colorWithHexString:@"0xFF3400"]

#define  MIN_PWD_LEN 8

@interface HATPasswordStrengthCalculater ()

@property (strong, nonatomic)  UIImageView *riskLevelImgl;
@property (strong, nonatomic)  UIImageView *riskLevelImg2;
@property (strong, nonatomic)  UIImageView *riskLevelImg3;

@property (strong, nonatomic)  NSString *passWordString;
@property (strong, nonatomic)  UILabel *riskLevelLabel;
@property (strong, nonatomic)  NSArray *riskPwdArray;
@end


@implementation HATPasswordStrengthCalculater

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.riskLevelLabel];
        [self addSubview:self.riskLevelImgl];
        [self addSubview:self.riskLevelImg2];
        [self addSubview:self.riskLevelImg3];
        
        self.riskPwdArray = @[@"admin@123", @"P@ssw0rd", @"1qazxsw2", @"Password123",@"qwe123!@#", @"admin123",
                              @"q1w2e3r4", @"Huawei@123", @"12345qwert!@#$%", @"1qaz#EDC5tgb",@"root123!@#", @"abcd123456",
                              @"root@123", @"123qwe!#", @"123qweasd", @"welcome@123",@"lq2w3e4r", @"system123",
                              @"!@#$qwerASDF", @"4rfv$RFV", @"cyidc!@#", @"huawei@123",@"lqaz2wsx", @"Admin123",
                              @"Administrator", @"Admin321", @"Linux123", @"root2012",@"root@2012", @"admin@2012",
                              @"root@root", @"iptv1234", @"iptv@123", @"admin1234",@"admin12345", @"admin888",
                              @"admin@123456", @"admin@321", @"admin_!@#", @"admin_!@#$",   @"admin_1234",@"adminsec1234",
                              @"Abc123"
                              ];
        
        [self rangeUI];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.riskLevelLabel];
        [self addSubview:self.riskLevelImgl];
        [self addSubview:self.riskLevelImg2];
        [self addSubview:self.riskLevelImg3];
        
        [self rangeUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.riskLevelLabel];
        [self addSubview:self.riskLevelImgl];
        [self addSubview:self.riskLevelImg2];
        [self addSubview:self.riskLevelImg3];
        
        [self rangeUI];
    }
    return self;
}

#pragma mark - Get & Set
- (void)setPassWordString:(NSString *)newPassWord {
    if (newPassWord != _passWordString) {
        _passWordString = newPassWord;
        [self changeLevelForText];
    }
}

- (UILabel*)riskLevelLabel {
    if(!_riskLevelLabel) {
        _riskLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,50, 16)];
        _riskLevelLabel.font = [UIFont systemFontOfSize:12];
        _riskLevelLabel.textColor = kColorPwdLabelLowLevel;
        _riskLevelLabel.text = NSLocalizedString(@"风险", @"风险");
        _riskLevelLabel.textAlignment = NSTextAlignmentRight;
    }
    return _riskLevelLabel;
}

- (UIImageView*)riskLevelImgl {
    if (!_riskLevelImgl) {
        _riskLevelImgl = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 7)];
        _riskLevelImgl.backgroundColor = kColorCCC;
    }
    return _riskLevelImgl;
}

- (UIImageView*)riskLevelImg2 {
    if (!_riskLevelImg2) {
        _riskLevelImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 7)];
        _riskLevelImg2.backgroundColor = kColorCCC;
    }
    return _riskLevelImg2;
}

- (UIImageView*)riskLevelImg3 {
    if (!_riskLevelImg3) {
        _riskLevelImg3 =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 7)];
        _riskLevelImg3.backgroundColor = kColorCCC;
    }
    return _riskLevelImg3;
}

#pragma mark - Private
- (BOOL)isRiskPwd {
    for (NSString *key in _riskPwdArray) {
        if ([key  isEqualToString:_passWordString]) {
            return YES;
        }
    }
    return NO;
}
- (void)changeLevelForText {
    if (_passWordString.length == 0 ) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    if (_passWordString.length < MIN_PWD_LEN || [self isRiskPwd]) {
        [self setLevel:PASS_WORD_RISK];
    } else {
        NSInteger alength = [_passWordString length];
        int  contentType = 0; //数字 字母大写 字母小写 特殊字符
        int  hasNum = 0;
        int  hasUperCase = 0;
        int  hasLowerCase = 0;
        int  hasOther = 0;
        
        for (int i = 0; i<alength; i++) {
            char commitChar = [_passWordString characterAtIndex:i];
            NSString *temp = [_passWordString substringWithRange:NSMakeRange(i,1)];
            const char *u8Temp = [temp UTF8String];
            if (strlen(u8Temp) > 1){
                hasOther = 1;
                NSLog(@"字符串中含有中文");
            } else if ((commitChar > 64) && (commitChar < 91)) {
                hasUperCase = 1;;
            } else if ((commitChar > 96)&&(commitChar < 123)) {
                hasLowerCase = 1;
            } else if ((commitChar > 47)&&(commitChar < 58)) {
                hasNum = 1;
            } else {
                hasOther = 1;
                NSLog(@"字符串中含有特殊符号");
            }
        }
        
        contentType = hasNum + hasUperCase + hasLowerCase + hasOther;

        if(contentType == 1 ) {
            [self setLevel:PASS_WORD_RISK];
        } else if (contentType == 2 ) {
            if (hasNum && ( hasUperCase || hasLowerCase )) {
                [self setLevel:PASS_WORD_LOW];
            } else {
                [self setLevel:PASS_WORD_MID];
            }
        } else if(contentType > 2 ){
            [self setLevel:PASS_WORD_STRONG];
        }
    }
}

- (void)rangeUI {
    
    [self.riskLevelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-2);
        make.right.mas_equalTo(self.riskLevelImgl.mas_left).offset(-6);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(14);
    }];
    
    [self.riskLevelImgl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.riskLevelLabel.mas_centerY);
        make.right.mas_equalTo(self.riskLevelImg2.mas_left).offset(-2);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(7);
    }];
    
    [self.riskLevelImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.riskLevelLabel.mas_centerY);
         make.right.mas_equalTo(self.riskLevelImg3.mas_left).offset(-2);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(7);
    }];
    
    [self.riskLevelImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.riskLevelLabel.mas_centerY);
        make.right.mas_equalTo(self).offset(-2);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(7);
    }];
}
    
- (void)setLevel:(PassWordLevelType)level {
    switch (level) {
        case PASS_WORD_RISK:
        {
            self.riskLevelLabel.text = NSLocalizedString(@"风险", @"风险");
            self.riskLevelLabel.textColor = kColorPwdLabelLowLevel;
            self.riskLevelImgl.backgroundColor = kColorCCC;
            self.riskLevelImg2.backgroundColor = kColorCCC;
            self.riskLevelImg3.backgroundColor = kColorCCC;
        }
        break;
        case PASS_WORD_LOW:
        {
            self.riskLevelLabel.text = NSLocalizedString(@"弱", @"弱");
            self.riskLevelLabel.textColor = kColorPwdLabelLowLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorCCC;
            self.riskLevelImg3.backgroundColor = kColorCCC;
        }
        break;
        case PASS_WORD_MID:
        {
            self.riskLevelLabel.text = NSLocalizedString(@"中", @"中");
            self.riskLevelLabel.textColor = kColorPwdLabelMidLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg3.backgroundColor = kColorCCC;
        }
        break;
        case PASS_WORD_STRONG:
        {
            self.riskLevelLabel.text = NSLocalizedString(@"强", @"强");
            self.riskLevelLabel.textColor = kColorPwdLabelStrongLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg3.backgroundColor = kColorPwdImgStrongLevel;
        }
        break;
        
        default:
        break;
    }
}

@end
