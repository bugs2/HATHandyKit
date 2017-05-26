//
//  HATCircleView.m
//  tryFrame
//
//  Created by jiangwei9 on 14/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATCircleProgressView.h"

@interface HATCircleProgressView ()
@property (strong, nonatomic) NSTimer *animationTimer;
@property (assign, nonatomic) CGFloat curProgress;
@property (assign, nonatomic) CGFloat tarProgress;
@end

@implementation HATCircleProgressView

- (void)drawRect:(CGRect)rect {
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    CGFloat startX = viewW * 0.5;  //圆心x坐标
    CGFloat startY = viewH * 0.5;  //圆心y坐标
    CGFloat radius = viewW * 0.5 - MAX(self.backCircleWidth, self.progressCircleWidth); //留一个像素给边缘
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //圆弧背景
    CGContextSetLineWidth(context, self.backCircleWidth);
    CGContextAddArc(context, startX, startY, radius, 0, 2 * M_PI, 0);
    CGContextSetStrokeColorWithColor(context, self.backCircleColor.CGColor);
    CGContextStrokePath(context);
    
    //圆弧内容
    CGContextSetLineWidth(context, self.progressCircleWidth);
    CGContextAddArc(context, startX, startY, radius, M_PI_2 * 3, M_PI_2 * 3 - 2 * M_PI * _progress, 1);
    CGContextSetStrokeColorWithColor(context, self.progressCircleColor.CGColor);
    CGContextStrokePath(context);
}

#pragma mark - Public
- (void)setProgress:(CGFloat)progress {
    progress = progress < 0 ? 0 : progress;
    progress = progress > 1 ? 1 : progress;
    
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgressAnimation:(CGFloat)progress {
    progress = progress < 0 ? 0 : progress;
    progress = progress > 1 ? 1 : progress;
    
    //关闭之前动画
    [self.animationTimer invalidate];
    self.animationTimer = nil;
    
    // 创建
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                                           target:self
                                                         selector:@selector(animationHandler)
                                                         userInfo:nil
                                                          repeats:YES];
    _curProgress = 0;
    _tarProgress = progress;
    self.progress = 0;
}


#pragma mark - Event
- (void)animationHandler {
    if (_curProgress < _tarProgress) {
        _curProgress = _curProgress + _tarProgress / 60;
        [self setProgress:_curProgress];
    } else {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
}

@end
