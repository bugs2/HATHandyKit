//
//  HATProgressTimer.h
//  TBox
//
//  Created by jiangwei9 on 31/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ProgressBlock)(CGFloat progress);

//封装NSTimer，按一定频率渐进到指定Progress，每次回调Block，返回过程Progress
//如:HZ=60,TotalTime=1,Progress:0.92，1秒钟完成0到0.92的渐进，每1/60回调一次ProgressBlock
//ProgressBlock在调用setProgress方法线程中执行，若执行UI相关操作，建议在主线程中调用setProgress方法，或者在Block中分发
@interface HATProgressTimer : NSObject

//默认HZ=60，totalTime=1
- (instancetype)initWithBlock:(ProgressBlock)progressBlock;

//HZ不建议超过60， TotalTime单位秒
- (instancetype)initWithHZ:(CGFloat)HZ totalTime:(CGFloat)second block:(ProgressBlock)progressBlock;

//Progress范围0到1，设置后定时器自动开始
- (void)setProgress:(CGFloat)progress;

//停止定时器
- (void)invalidate;
@end
