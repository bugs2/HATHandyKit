//
//  CYPasswordInputView.m
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import "CYPasswordInputView.h"
#import "CYConst.h"
#import "UIView+Extension.h"

#define kNumCount 6

@interface CYPasswordInputView ()

/** 保存用户输入的数字集合 */
@property (nonatomic, strong) NSMutableArray *inputNumArray;
/** 关闭按钮 */
@property (nonatomic, weak) UIButton *btnClose;
/** 忘记密码 */
@property (nonatomic, weak) UIButton *btnForgetPWD;
/** 正在加载 */
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation CYPasswordInputView

#pragma mark  - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        /** 注册通知 */
        [self setupNotification];
        /** 添加子控件 */
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置关闭按钮的坐标
    self.btnClose.width = CYPasswordViewCloseButtonWH;
    self.btnClose.height = CYPasswordViewCloseButtonWH;
    self.btnClose.x = CYPasswordViewCloseButtonMarginLeft;
    self.btnClose.centerY = CYPasswordViewTitleHeight * 0.5;

    // 设置忘记密码按钮的坐标
    self.btnForgetPWD.x = CYScreenWith - (CYScreenWith - CYPasswordViewTextFieldWidth) * 0.5 - self.btnForgetPWD.width;
    self.btnForgetPWD.y = CYPasswordViewTitleHeight + CYPasswordViewTextFieldMarginTop + CYPasswordViewTextFieldHeight + CYPasswordViewForgetPWDButtonMarginTop;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 添加子控件 */
- (void)setupSubViews
{
    /** 关闭按钮 */
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnCancel];
    [btnCancel setImage:[UIImage imageNamed:CYPasswordViewSrcName(@"control_password_close")] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.btnClose = btnCancel;
    [self.btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];

    /** 忘记密码按钮 */
    UIButton *btnForgetPWD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnForgetPWD];
    [btnForgetPWD setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [btnForgetPWD setTitleColor:kColorBrandBlue forState:UIControlStateNormal];
    [btnForgetPWD setTitleColor:kColorButtonSelected forState:UIControlStateHighlighted];
    btnForgetPWD.titleLabel.font = CYFont(12);
    [btnForgetPWD sizeToFit];
    self.btnForgetPWD = btnForgetPWD;
    [self.btnForgetPWD addTarget:self action:@selector(btnForgetPWD_Click:) forControlEvents:UIControlEventTouchUpInside];
}

/** 注册通知 */
- (void)setupNotification {
    // 用户按下删除键通知
    [CYNotificationCenter addObserver:self selector:@selector(delete) name:CYPasswordViewDeleteButtonClickNotification object:nil];
    // 用户按下数字键通知
    [CYNotificationCenter addObserver:self selector:@selector(number:) name:CYPasswordViewNumberButtonClickNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewDisEnabledUserInteractionNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewEnabledUserInteractionNotification object:nil];
}

// 按钮点击
- (void)btnClose_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewCancleButtonClickNotification object:self];
    [self.inputNumArray removeAllObjects];
}

- (void)btnForgetPWD_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewForgetPWDButtonClickNotification object:self];
}

- (void) disEnalbeCloseButton:(NSNotification *)notification{
    BOOL flag = [[notification.object valueForKeyPath:@"enable"] boolValue];
    self.btnClose.userInteractionEnabled = flag;
    self.btnForgetPWD.hidden = !flag;
    self.isLoading = !flag;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 背景线条
    CGRect rectLine = CGRectMake(0, CYPasswordViewTitleHeight, kScreen_Width, 0.75);
    UIImage *imgLine = [UIImage imageWithColor:kColorTableSeperator];
    [imgLine drawInRect:rectLine];

    
    // 画标题
    NSString *title = self.title ? self.title : @"输入交易密码";
    UIColor *titleColor = self.titleColor ? self.titleColor : kColor333;

    
    NSDictionary *arrts = @{NSFontAttributeName:CYFont(12)};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = (CYPasswordViewTitleHeight - titleH) * 0.5;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = CYFont(12);
    attr[NSForegroundColorAttributeName] = titleColor;
    [title drawInRect:titleRect withAttributes:attr];
    
    // 加载中隐藏输入框
    if (!self.isLoading) {
        // 输入框
        UIImage *imgTextfield = [UIImage imageNamed:CYPasswordViewSrcName(@"password_textfield")];
        CGFloat textfieldY = CYPasswordViewTitleHeight + CYPasswordViewTextFieldMarginTop;
        CGFloat textfieldW = CYPasswordViewTextFieldWidth;

        CGFloat textfieldX = (CYScreenWith - textfieldW) * 0.5;
        CGFloat textfieldH = CYPasswordViewTextFieldHeight;
        [imgTextfield drawInRect:CGRectMake(textfieldX, textfieldY, textfieldW, textfieldH)];
        
        // 画点
        UIImage *pointImage = [UIImage imageNamed:CYPasswordViewSrcName(@"password_point")];
        CGFloat pointW = CYPasswordViewPointnWH;
        CGFloat pointH = CYPasswordViewPointnWH;
        CGFloat pointY =  textfieldY + (textfieldH - pointH) * 0.5;
        __block CGFloat pointX;
        
        // 一个格子的宽度
        CGFloat cellW = textfieldW / kNumCount;
        CGFloat padding = (cellW - pointW) * 0.5;
        [self.inputNumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            pointX = textfieldX + (2 * idx + 1) * padding + idx * pointW;
            [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
        }];
    }
}

#pragma mark  - 懒加载
- (NSMutableArray *)inputNumArray {
    if (_inputNumArray == nil) {
        _inputNumArray = [NSMutableArray array];
    }
    return _inputNumArray;
}

#pragma mark  - 私有方法
// 响应用户按下删除键事件
- (void)delete {
    [self.inputNumArray removeLastObject];
    [self setNeedsDisplay];
}

// 响应用户按下数字键事件
- (void)number:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSString *numObj = userInfo[CYPasswordViewKeyboardNumberKey];
    if (numObj.length >= kNumCount) return;
    
    //清楚所有密码
    if (numObj.length == 0) {
        [self.inputNumArray removeAllObjects];
    } else {
        [self.inputNumArray addObject:numObj];
    }
    
    [self setNeedsDisplay];
}

@end