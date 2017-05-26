//
//  HATPatternLockViews.m
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import "HATPatternLockViews.h"
#import "HATPatternLockItem.h"
#import "HATPatternLockThumbnailView.h"
#import "HATPatternLockHandler.h"
#import "HATUserEntity.h"

#define KscreenHeight [UIScreen mainScreen].bounds.size.height
#define KscreenWidth [UIScreen mainScreen].bounds.size.width

//#define WindowScaleToIphone6 44  // 手机号码lable的高度
#define PatternLock_Set_TopPhoneLabelY 46     // 手机号码lable的位置的y坐标(有navigaitonbar）

#define PatternLock_Verify_TopPhoneLabelY 70  // 手机号码lable的位置的y坐标(无navigaitonbar）

#define PatternLockItemWidth          70  // item的宽高
#define PatternLockItemTop            (PatternLockTopPhoneLabelHeight + 60) // 整个items的Y位置

#define PatternLockItemTag            111 // item起始tag

/*********************** 文字提示语 *************************/
#define SETPSWSTRING          NSLocalizedString(@"请绘制手势密码图案", "请绘制手势密码图案")
#define RESETPSWSTRING        NSLocalizedString(@"请再次绘制手势密码图案", @"请再次绘制手势密码图案")
#define PSWSUCCESSSTRING      NSLocalizedString(@"设置密码成功", @"设置密码成功")
#define PSWFAILTSTRING        NSLocalizedString(@"手势密码错误", @"手势密码错误")
#define PSW_WRONG_NUMSTRING   NSLocalizedString(@"至少连接4个点，请重试", @"至少连接4个点，请重试")
#define INPUT_OLD_PSWSTRING   NSLocalizedString(@"请输入原始密码", @"请输入原始密码")
#define INPUT_NEW_PSWSTRING   NSLocalizedString(@"请输入新密码", @"请输入新密码")
#define VALIDATE_PSWSTRING    NSLocalizedString(@"请绘制手势解锁", @"请绘制手势解锁")
#define VALIDATE_PSWSTRING_SUCCESS    NSLocalizedString(@"验证成功", @"验证成功")

@interface HATPatternLockViews ()

@property (strong, nonatomic) NSMutableArray *buttonsArray;                 // 用于存放九个圆形按钮
@property (assign, nonatomic) CGPoint movePoint;                            //
@property (strong, nonatomic) UILabel *phoneNumLabel;   // 手机号
@property (strong, nonatomic) UILabel *messageLable;                        // 用于显示一些提示信息
@property (strong, nonatomic) UIButton *resetButton;                        // 重新绘制按钮
@property (strong, nonatomic) UIButton *passWordLoginButton;                // 账号密码登录按钮
@property (assign, nonatomic) CGPoint lastPoint;                            //
@property (assign, nonatomic) CGFloat centerYPoint;
@property (assign, nonatomic) CGFloat spaceFloat;

@property (strong, nonatomic) UIColor *lineColor;                           // 线条颜色
@property (strong, nonatomic) UIColor *selectedColor;                       // 选中时的按钮颜色
@property (strong, nonatomic) UIColor *itemsFillColor;                      // 按钮Normal时的填充色
@property (strong, nonatomic) UIColor *messageLableWrongColor;              // 错误信息文字颜色

@end

@implementation HATPatternLockViews

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame mode:(HATPatternLockViewsMode)patternLockViewsMode {
    self = [super initWithFrame:frame];
    if (self) {
        //登录认证时没有导航条
        self.spaceFloat = (KscreenWidth - 3 * PatternLockItemWidth) / 4; //每个item的间距是等宽的
        //CGFloat centerY = (patternLockViewsMode == HATPatternLockViewsModeVerification ) ? (KscreenHeight - 20) / 2 : (KscreenHeight -64) / 2;
        CGFloat centerY = frame.size.height / 2;
        self.centerYPoint  = centerY - 1.5 * PatternLockItemWidth - self.spaceFloat;  //第一个圆圈的起点Y
        
        self.patternLockViewsMode = patternLockViewsMode;
        self.lineColor =   kColorBrandBlue;
        self.selectedColor =  kColorBrandBlue;//  kColorBrandBlue;
        self.itemsFillColor = [UIColor clearColor];     //[kColorBrandBlue colorWithAlphaComponent:0.2];
        self.messageLableWrongColor = kColorBrandError;

        [self initSubViews];
    }

    return self;
}

#pragma mark - Setter
- (void)setPatternLockViewsMode:(HATPatternLockViewsMode)patternLockViewsMode {
    _patternLockViewsMode = patternLockViewsMode;
    self.messageLable.textColor = kColor333;
    
    switch (patternLockViewsMode) {
        case HATPatternLockViewsModeModify: {
            //修改密码
            self.messageLable.text = INPUT_OLD_PSWSTRING;
            break;
        }
            
        case HATPatternLockViewsModeSet: {
            // 设置密码
            [HATPatternLockHandler deletePsw];
            self.messageLable.text = SETPSWSTRING;
            break;
        }
            
        case HATPatternLockViewsModeVerification: {
            // 验证密码
            self.messageLable.text = VALIDATE_PSWSTRING;
            break;
        }
            
        case HATPatternLockViewsModeDelete: {
            // 删除密码
            // 先验证再删除（暂未实现）
            [HATPatternLockHandler deletePsw];
            break;
        }
            
        case HATPatternLockViewsModeNone: {
            
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - Getter
- (NSMutableArray *)buttonsArray {
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    return _buttonsArray;
}

- (UILabel *)phoneNumLabel {
    if (!_phoneNumLabel) {
        _phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.centerYPoint - 64, KscreenWidth, 18)];
        _phoneNumLabel.textAlignment = NSTextAlignmentCenter;
        _phoneNumLabel.textColor = kColor999;
        _phoneNumLabel.text = [[AppContext sharedInstance].preMobileNum replaceWithReplacingString:@"*" atRange:NSMakeRange(3, 4) shouldRepeat:YES];
        _phoneNumLabel.font = [UIFont systemFontOfSize:14];
        _phoneNumLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_phoneNumLabel];
    }
    return _phoneNumLabel;
}

- (UILabel *)messageLable {
    if (!_messageLable) {
        _messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.centerYPoint - 35, KscreenWidth , 15)];
        _messageLable.textAlignment = NSTextAlignmentCenter;
        _messageLable.textColor = kColor333;
        _messageLable.font = [UIFont systemFontOfSize:12];
        _messageLable.text = SETPSWSTRING;
        _messageLable.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        [self addSubview:_messageLable];

    }
    return _messageLable;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        int bottomeEge = 66;
        _resetButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - bottomeEge, KscreenWidth, 30)];
        
        _resetButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_resetButton setTitle:NSLocalizedString(@"重新绘制", @"重新绘制") forState:UIControlStateNormal];
        [_resetButton setTitleColor:kColor333 forState:UIControlStateNormal];
        [_resetButton setTitleColor:kColor999 forState:UIControlStateHighlighted];
        [_resetButton addTarget:self action:@selector(resetButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_resetButton];
        
        _resetButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _resetButton.hidden = YES;
    }
    return _resetButton;
}

- (UIButton *)passWordLoginButton {
    if (!_passWordLoginButton) {
        int bottomeEge = 66;
        _passWordLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - bottomeEge, KscreenWidth, 30)];
        
        _passWordLoginButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_passWordLoginButton setTitle:NSLocalizedString(@"账号密码登录", @"账号密码登录") forState:UIControlStateNormal];
        [_passWordLoginButton setTitleColor:kColor333 forState:UIControlStateNormal];
        [_passWordLoginButton setTitleColor:kColor999 forState:UIControlStateHighlighted];
        [_passWordLoginButton addTarget:self action:@selector(passWordLoginButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_passWordLoginButton];
        
        _passWordLoginButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        _passWordLoginButton.hidden = YES;
        if (self.patternLockViewsMode == HATPatternLockViewsModeVerification){
             _passWordLoginButton.hidden = NO;
        }
    }
    return _passWordLoginButton;
}


- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [kColorBrandBlue colorWithAlphaComponent:0.4]; //[UIColor colorWithRed:0.13 green:0.7 blue:0.96 alpha:1];DD
    }
    return _lineColor;
}

#pragma mark - Event 
- (void)resetButtonEvent:(UIButton *)sender {
    if (self.patternLockViewsMode == HATPatternLockViewsModeSet) {
        self.messageLable.textColor = kColor333;
        self.messageLable.text = SETPSWSTRING;
        _resetButton.hidden = YES;
        [HATPatternLockHandler deletePsw];
    }
}

- (void)passWordLoginButtonEvent:(UIButton *)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (event.allTouches.count > 1) {
        // 只支持单点触控
        return;
    }
    
    CGPoint point = [self touchLocation:touches];
    
    [self isContainItem:point];
    
    if (self.showDirection) {
        [self touchMove_triangleAction];
    }
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    [self touchEndAction];
    
}

#pragma mark - Private
- (void)initSubViews {
//    self.backgroundColor = BACKGROUNDCOLOR;
    
    /***** 提示文字 ******/
    self.phoneNumLabel.backgroundColor = [UIColor clearColor];
    
    self.messageLable.backgroundColor = [UIColor clearColor];
    
    /****** 9个大点的布局 *****/
    [self createPatternLockItems];
    
    /******* 小按钮上三角的point ******/
    self.lastPoint = CGPointMake(0, 0);
    
    self.resetButton.backgroundColor = [UIColor clearColor];
    self.passWordLoginButton.backgroundColor = [UIColor clearColor];
}

- (void)createPatternLockItems {
    
    for (int i = 0; i < 9; i++) {
        int row    = i / 3;
        int column = i % 3;
        

        CGFloat pointX    = self.spaceFloat * (column + 1) + PatternLockItemWidth * column; //起点X
        //登录认证时没有导航条
        //CGFloat centerY = (self.patternLockViewsMode == HATPatternLockViewsModeVerification ) ? (KscreenHeight - 20) / 2 : (KscreenHeight -64) / 2;
        CGFloat centerY = self.frame.size.height / 2 ;
        CGFloat pointY     = (centerY - 1.5 * PatternLockItemWidth - self.spaceFloat) + PatternLockItemWidth * row + self.spaceFloat * row;     //起点Y
        /**
         *  对每一个item的frame的布局
         */
        HATPatternLockItem *item = [[HATPatternLockItem alloc] initWithFrame:CGRectMake(pointX, pointY, PatternLockItemWidth, PatternLockItemWidth)];
        item.userInteractionEnabled = YES;
        item.backgroundColor = [UIColor clearColor];
        item.fillColor = self.itemsFillColor;   // 填充色
        item.selectedColor = self.selectedColor;  // 选中时的颜色
        item.triangleLayerColor = self.selectedColor; // 方向箭头颜色
        item.isSelected = NO;
        item.tag = PatternLockItemTag + i ;
        [self addSubview:item];
        item.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        NSLog(@"item.frame = [%@]", NSStringFromCGPoint(item.center));
    }
}

/* 晃动效果 */
- (void)shake:(UIView *)myView {
    int offset = 8 ;
    
    CALayer *lbl = [myView layer];
    CGPoint posLbl = [lbl position];
    CGPoint y = CGPointMake(posLbl.x-offset, posLbl.y);
    CGPoint x = CGPointMake(posLbl.x+offset, posLbl.y);
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.06];
    [animation setRepeatCount:2];
    [lbl addAnimation:animation forKey:nil];
}

/* Touch begin move */
- (CGPoint)touchLocation:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _movePoint = point;
    return point;
}

- (void)isContainItem:(CGPoint)point {
    for (HATPatternLockItem *item  in self.subviews) {
        if (![item isKindOfClass:[HATPatternLockThumbnailView class]] && [item isKindOfClass:[HATPatternLockItem class]]) {
            BOOL isContain = CGRectContainsPoint(item.frame, point);
            if (isContain && item.isSelected == NO) {
                [self.buttonsArray addObject:item];
                item.isSelected = YES;
                item.itemStyle = HATPatternLockItemStyleSelected;
            }
        }
    }
}

/* 绘制手势方向 */
- (void)touchMove_triangleAction {
    NSString *resultStr = [self getDigitalCode];
    if (resultStr && resultStr.length > 0) {
        NSMutableArray *passwordArray = [NSMutableArray array];
        
        [resultStr enumerateSubstringsInRange:NSMakeRange(0, resultStr.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            
            [passwordArray addObject:substring];
            
        }];

        if ([passwordArray isKindOfClass:[NSArray class]] &&
            passwordArray.count > 1) {
            NSString *lastItemTag    = passwordArray[passwordArray.count - 1];
            NSString *secondLastItemTag = passwordArray[passwordArray.count - 2];
            
            CGPoint lastPoint = CGPointZero;
            CGPoint secondLastPoint = CGPointZero;
            HATPatternLockItem *lastItem;
            
            for (HATPatternLockItem *item in self.buttonsArray) {
                if (item.tag - PatternLockItemTag == lastItemTag.intValue) {
                    lastPoint = item.center;
                }
                
                if (item.tag - PatternLockItemTag == secondLastItemTag.intValue) {
                    secondLastPoint = item.center;
                    lastItem = item;
                }
                
                CGFloat x1 = secondLastPoint.x;
                CGFloat y1 = secondLastPoint.y;
                CGFloat x2 = lastPoint.x;
                CGFloat y2 = lastPoint.y;
                
                [lastItem showDirectionWithStartPoint:CGPointMake(x1, y1) endPoint:CGPointMake(x2, y2) shouldHidden:NO];
            }
        }
    }
}

/* Touch end */
- (void)touchEndAction {
    
    if (self.buttonsArray.count < 1) {
        [self restoreState];
        return;
    }
    
    for (HATPatternLockItem *item in self.buttonsArray) {
        [item showDirectionWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 0) shouldHidden:NO];
    }
    
    // if (判断格式少于4个点) [分类处理密码数据]
    if ([self judgePatternLockFormat]) {
        if(![self setPatternLockWithPassword:[self getDigitalCode]]) {
            [self setWrongGestureState];
        } else {
             [self restoreState];
        }
    } else {
        [self setWrongGestureState];
    }
    
}

- (void)setWrongGestureState {
    self.userInteractionEnabled = NO;
    self.lineColor =   kColorBrandRed;
    _movePoint.x=0 ;
    _movePoint.y=0 ;
    for (int i=0; i < self.buttonsArray.count; i++) {
        HATPatternLockItem *item = (HATPatternLockItem *)self.buttonsArray[i];
        item.isSelected = YES;
        item.itemStyle = HATPatternLockItemStyleWrong;
    }
    
    [self setNeedsDisplay];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self restoreState];
    });
}

- (void)restoreState {
    // 数组清空
    self.lineColor = kColorBrandBlue;
    _movePoint.x=0 ;
    _movePoint.y=0 ;
    [self.buttonsArray removeAllObjects];
    
    // 选中样式
    for (HATPatternLockItem *item  in self.subviews) {
        if (![item isKindOfClass:[HATPatternLockThumbnailView class]] && [item isKindOfClass:[HATPatternLockItem class]]) {
            item.isSelected = NO;
            item.itemStyle = HATPatternLockItemStyleNormal;
            [item showDirectionWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 0) shouldHidden:YES];
        }
    }
    
    [self setNeedsDisplay];
    
    self.userInteractionEnabled = YES;
}

/* 验证密码是否符合条件 */
- (BOOL)judgePatternLockFormat {
    
    if (self.patternLockViewsMode == HATPatternLockViewsModeVerification &&
        [HATPatternLockHandler isSave]) {
        return YES;
    }
    
    if (self.buttonsArray.count <= 3) {
        //不合法
        self.messageLable.textColor = self.messageLableWrongColor;
        self.messageLable.text      = PSW_WRONG_NUMSTRING;
        [self shake:self.messageLable];
        return NO;
    }
    
    return YES;
}

/* 将图形密码转化为数字字符串 */
- (NSString *)getDigitalCode {
    NSMutableString *resultStr = [NSMutableString string];
    
    for (HATPatternLockItem *item in self.buttonsArray) {
        if (![item isKindOfClass:[HATPatternLockThumbnailView class]] && [item isKindOfClass:[HATPatternLockItem class]]) {
            [resultStr appendString:[NSString stringWithFormat:@"%ld", (long)item.tag - PatternLockItemTag]];
        }
    }
    
    return (NSString *)resultStr;
}

#pragma mark - 业务逻辑
- (BOOL)setPatternLockWithPassword:(NSString *)password {
    //没有任何记录，第一次登录
    BOOL isSaveBool = [HATPatternLockHandler isFirstInput:password];
    
    BOOL isSuccess = YES;
    
    if (isSaveBool) {
        
        //第一次输入之后，显示的文字
        self.messageLable.text = RESETPSWSTRING;
        self.messageLable.textColor = kColor333;
        
        // 到达设置验证步骤时 显示按钮
        if (self.patternLockViewsMode == HATPatternLockViewsModeSet) {
            self.resetButton.hidden = NO;
        }
        
    } else {
        // 密码已经存在
        
        //设置密码
        if (self.patternLockViewsMode == HATPatternLockViewsModeSet) {
            isSuccess = [self setPwdJudgeAction:password];
        } else if (self.patternLockViewsMode == HATPatternLockViewsModeModify) {
            //修改密码
            isSuccess = [self alertPwdJudgeAction:password];
        } else if (self.patternLockViewsMode == HATPatternLockViewsModeVerification) {
            //验证密码
            isSuccess = [self validatePwdJudgeAction:password];
        }
        
    }
    
    return isSuccess;
}

/* 第二次验证密码 */
- (BOOL)setPwdJudgeAction:(NSString *)resultStr {
    /**
     *  设置密码
     */
    if (self.patternLockViewsMode == HATPatternLockViewsModeSet) {
        
        // isRight == YES 2次的密码相同
        BOOL isRight = [HATPatternLockHandler isSecondInputRight:resultStr];
        if (isRight) {
            // 验证成功
            
            //self.messageLable.text = PSWSUCCESSSTRING;
            //self.messageLable.textColor = kColor333;
            //[self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            [self blockAction:resultStr];
            
        } else {
            
            // 失败
            self.messageLable.text = PSWFAILTSTRING;
            self.messageLable.textColor = self.messageLableWrongColor;
            [self shake:self.messageLable];
            if (self.failureBlock) {
                self.failureBlock(self.patternLockViewsMode);
            }
            
            return NO;
        }
    }
    return YES;
}

/* 修改密码 */
- (BOOL)alertPwdJudgeAction:(NSString *)resultStr {
    /**
     *  修改
     */
    if (self.patternLockViewsMode == HATPatternLockViewsModeModify) {
        BOOL isValidate = [HATPatternLockHandler isSecondInputRight:resultStr];
        if (isValidate) {
            
            //如果验证成功
            [HATPatternLockHandler deletePsw];
            self.messageLable.text = INPUT_NEW_PSWSTRING;
            self.messageLable.textColor = kColor333;
            _patternLockViewsMode = HATPatternLockViewsModeSet;
            
        } else {
            //验证失败
            self.messageLable.text = PSWFAILTSTRING;
            self.messageLable.textColor = self.messageLableWrongColor;
            [self shake:self.messageLable];
            return NO;
        }
    }
    return YES;
}

/* 验证，登录 */
- (BOOL)validatePwdJudgeAction:(NSString *)resultStr {
    
    
    if (self.patternLockViewsMode == HATPatternLockViewsModeVerification) {
        BOOL isValidate = [HATPatternLockHandler isSecondInputRight:resultStr];
        if (isValidate) {
            //如果验证成功,会自动登录，自动登录成功，
//            self.messageLable.text = @"";
//            self.messageLable.textColor = kColor333;
            //[self performSelector:@selector(blockAction:) withObject:resultStr afterDelay:.8];
            [self blockAction:resultStr];
            
        } else {
            //失败
            self.messageLable.text = PSWFAILTSTRING;
            self.messageLable.textColor = self.messageLableWrongColor;
            [self shake:self.messageLable];
            if (self.failureBlock) {
                self.failureBlock(self.patternLockViewsMode);
            }
            
            return NO;
        }
    }
    
    return YES;
}

/* 成功的block回调 */
- (void)blockAction:(NSString *)resultStr {
    if (self.successBlock) {
        
        //_patternLockViewsMode = HATPatternLockViewsModeNone;
        self.successBlock(self.patternLockViewsMode);
    }
}

#pragma mark - DrawRect
/* 画连接线 */
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (int i=0; i < self.buttonsArray.count; i++) {
        HATPatternLockItem *item = (HATPatternLockItem *)self.buttonsArray[i];
        if (i == 0) {
            [path moveToPoint:item.center];
        } else {
            [path addLineToPoint:item.center];
        }
    }
    
    if (_movePoint.x!=0 && _movePoint.y!=0 && NSStringFromCGPoint(_movePoint)) {
        [path addLineToPoint:_movePoint];
    }
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineWidth:6.0f];
    [self.lineColor setStroke];
    [path stroke];
}

#pragma mark - Public

- (void)showMessage:(NSString *)message shouldAlert:(BOOL)shouldAlert {
    self.messageLable.text = message;
    if (shouldAlert) {
        self.messageLable.textColor = self.messageLableWrongColor;
         [self shake:self.messageLable];
    }
}

@end
