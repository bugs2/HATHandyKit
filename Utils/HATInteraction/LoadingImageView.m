//
//  LoadingImageView.m
//  AutoMobile
//
//  Created by ZC on 2016/10/11.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import "LoadingImageView.h"

@implementation LoadingImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc {
    [self.layer removeAllAnimations];
}

- (void)startAnimate {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        circleAnimation.removedOnCompletion = NO;
        circleAnimation.duration = 1.5f;
        circleAnimation.repeatCount = MAXFLOAT;
        circleAnimation.toValue = @(M_PI*2);
        [self.layer addAnimation:circleAnimation forKey:@"rotation"];
    });
}

- (void)stopAnimate {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.layer removeAllAnimations];
    });
}

@end
