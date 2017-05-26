//
//  HATProgressTimer.m
//  TBox
//
//  Created by jiangwei9 on 31/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATProgressTimer.h"

@interface HATProgressTimer ()
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CGFloat curProgress;
@property (assign, nonatomic) CGFloat tarProgress;
@property (assign, nonatomic) CGFloat HZ;
@property (assign, nonatomic) CGFloat totalTime;
@property (copy, nonatomic) ProgressBlock progressBlock;
@end

@implementation HATProgressTimer
#pragma mark - LifeCycle
- (instancetype)initWithBlock:(ProgressBlock)progressBlock{
    return [self initWithHZ:60 totalTime:1 block:progressBlock];
}

- (instancetype)initWithHZ:(CGFloat)HZ totalTime:(CGFloat)second block:(ProgressBlock)progressBlock {
    self = [super init];
    if (self) {
        _HZ = HZ;
        _totalTime = second;
        _progressBlock = progressBlock;
    }
    return self;
}

#pragma mark - Public
- (void)setProgress:(CGFloat)progress {
    progress = progress < 0 ? 0 : progress;
    progress = progress > 1 ? 1 : progress;

    //关闭之前定时器
    [self invalidate];
    
    //重新开始任务
    _timer = [NSTimer scheduledTimerWithTimeInterval:(1 / _HZ)
                                                      target:self
                                                    selector:@selector(timerHandler)
                                                    userInfo:nil
                                                     repeats:YES];
    _curProgress = 0;
    _tarProgress = progress;
    if(_progressBlock) {
        _progressBlock(_curProgress);
    }
}

- (void)invalidate {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Event
- (void)timerHandler {
    if (_curProgress < _tarProgress) {
        _curProgress = _curProgress + _tarProgress / (_HZ * _totalTime);
        if(_progressBlock) {
            _progressBlock(_curProgress < _tarProgress ? _curProgress : _tarProgress);
        }
    } else {
        [self invalidate];
    }
}

@end
