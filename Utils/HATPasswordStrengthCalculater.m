//
//  HATPasswordStrengthCalculater.m
//  TBox
//
//  Created by zhuhuadong on 17/3/28.
//  Copyright © 2017年 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATPasswordStrengthCalculater.h"
#import <Masonry/Masonry.h>

#define  MIN_PWD_LEN 8

@interface HATPasswordStrengthCalculater ()

@property (strong, nonatomic)  UIImageView *riskLevelImgl;
@property (strong, nonatomic)  UIImageView *riskLevelImg2;
@property (strong, nonatomic)  UIImageView *riskLevelImg3;

@property (strong, nonatomic)  NSString *passWordString;
@property (strong, nonatomic)  UILabel *riskLevelLabel;

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
- (void)changeLevelForText {
    if (_passWordString.length < MIN_PWD_LEN) {
        self.riskLevelLabel.text = NSLocalizedString(@"风险", @"风险");
        self.riskLevelLabel.textColor = kColorPwdLabelLowLevel;
        self.riskLevelImgl.backgroundColor = kColorCCC;
        self.riskLevelImg2.backgroundColor = kColorCCC;
        self.riskLevelImg3.backgroundColor = kColorCCC;
    } else {
        NSInteger alength = [_passWordString length];
        int  contentType=0; //数字 字母大写 字母小写
        int  hasNum = 0;
        int  hasUperCase = 0;
        int  hasLowerCase = 0;
        
        for (int i = 0; i<alength; i++) {
            char commitChar = [_passWordString characterAtIndex:i];
            if ((commitChar > 64) && (commitChar < 91)) {
                hasUperCase = 1;;
            } else if ((commitChar > 96)&&(commitChar < 123)) {
                hasLowerCase = 1;
            } else if ((commitChar > 47)&&(commitChar < 58)) {
                hasNum = 1;
            }
        }
        
        contentType = hasNum+hasUperCase+hasLowerCase;
        
        if(contentType <= 1) {
            self.riskLevelLabel.text = NSLocalizedString(@"弱", @"弱");
            self.riskLevelLabel.textColor = kColorPwdLabelLowLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorCCC;
            self.riskLevelImg3.backgroundColor = kColorCCC;
        } else if (contentType == 2) {
            self.riskLevelLabel.text = NSLocalizedString(@"中", @"中");
            self.riskLevelLabel.textColor = kColorPwdLabelMidLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg3.backgroundColor = kColorCCC;
        } else {
            self.riskLevelLabel.text = NSLocalizedString(@"强", @"强");
            self.riskLevelLabel.textColor = kColorPwdLabelStrongLevel;
            self.riskLevelImgl.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg2.backgroundColor = kColorPwdImgStrongLevel;
            self.riskLevelImg3.backgroundColor = kColorPwdImgStrongLevel;
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

@end
