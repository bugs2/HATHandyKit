//
//  HATMJRefreshFooter.m
//  TOps
//
//  Created by jiangwei9 on 25/04/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

//
//  MJDIYAutoFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "HATMJRefreshFooter.h"
#import "HATLoadingImageView.h"


@interface HATMJRefreshFooter()
@property (weak, nonatomic) UIView *line1;
@property (weak, nonatomic) UIView *line2;
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIView *container;
@property (weak, nonatomic) HATLoadingImageView *loading;
@property (weak, nonatomic) UIView *backgroundView;
@end

@implementation HATMJRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 55;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kColor999;
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"已经到底了";
    self.label = label;
    
    //两条横线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 1)];
    line1.backgroundColor = kColor999;
    self.line1 = line1;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 1)];
    line2.backgroundColor = kColor999;
    self.line2 = line2;

    
    //提示内容
    UIView *container = [[UIView alloc] init];
    [container addSubview:self.label];
    [container addSubview:line1];
    [container addSubview:line2];
    [self addSubview:container];
    self.container = container;

    
    // loading
    HATLoadingImageView *loading = [[HATLoadingImageView alloc] initWithImage:[UIImage imageNamed:@"update"]];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.container.frame = self.bounds;
    self.label.frame = self.bounds;
    //计算文字距离
    CGSize size =  [self sizeWithString:self.label.text font:self.label.font maxSize:CGSizeMake(kScreen_Width, kScreen_Height)];
    
    self.line1.center = CGPointMake(self.mj_w * 0.5 - size.width * 0.5 - 15 - 30, self.mj_h * 0.5);
    self.line2.center = CGPointMake(self.mj_w * 0.5 + size.width * 0.5 + 15 + 30, self.mj_h * 0.5);
    self.label.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.container.hidden = YES;
            self.loading.hidden = NO;
            [self.loading stopAnimate];
            break;
        case MJRefreshStateRefreshing:
            self.container.hidden = YES;
            self.loading.hidden = NO;
            [self.loading startAnimate];
            break;
        case MJRefreshStateNoMoreData:
            self.container.hidden = NO;
            self.loading.hidden = YES;
            [self.loading stopAnimate];
            break;
        default:
            break;
    }
}

#pragma mark - Private
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGRect rect =  [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size;
}

@end
