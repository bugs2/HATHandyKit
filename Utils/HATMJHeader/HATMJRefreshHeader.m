//
//  HATMJRefreshHeader.m
//  MJRefreshExample
//
//  Created by jiangwei9 on 15/03/2017.
//  Copyright © 2017 小码哥. All rights reserved.
//

#import "HATMJRefreshHeader.h"
#import "HATLoadingImageView.h"

@interface HATMJRefreshHeader()
@property (weak, nonatomic) HATLoadingImageView *loading;
@property (weak, nonatomic) UIView *backgroundView;
@end


@implementation HATMJRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 55;
    self.backgroundColor = [UIColor colorWithHexString:@"0xEDECF2"];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    backgroundView.backgroundColor = [UIColor colorWithHexString:@"0xEDECF2"];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    // loading
    HATLoadingImageView *loading = [[HATLoadingImageView alloc] initWithImage:[UIImage imageNamed:@"update"]];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    self.backgroundView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
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
            [self.loading stopAnimate];
            break;
        case MJRefreshStatePulling:
            [self.loading startAnimate];
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimate];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    NSLog(@"pullingPercent %f", pullingPercent);
    [super setPullingPercent:pullingPercent];
    
//    CGFloat alpha = 1;
//    if (pullingPercent > 1 && pullingPercent < 2) {
//        alpha = 1 - (pullingPercent - 1);
//        alpha = alpha < 0.1 ? 0.1 : alpha;
//    }
//    
//    if (pullingPercent > 2) {
//        alpha = 0.1;
//    }
//    
//    NSLog(@"alpha %f", alpha);

    
//    self.backgroundColor = [UIColor colorWithHexString:@"0xEDECF2" andAlpha:alpha];
    
//    self.backgroundView.mj_h = 55 *  (1 + pullingPercent);
}

@end
