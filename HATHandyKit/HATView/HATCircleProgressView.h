//
//  HATCircleView.h
//  tryFrame
//
//  Created by jiangwei9 on 14/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface HATCircleProgressView : UIView

@property (assign, nonatomic) IBInspectable CGFloat progress;
@property (assign, nonatomic) IBInspectable CGFloat backCircleWidth;
@property (assign, nonatomic) IBInspectable CGFloat progressCircleWidth;
@property (strong, nonatomic) IBInspectable UIColor *backCircleColor;
@property (strong, nonatomic) IBInspectable UIColor *progressCircleColor;

- (void)setProgressAnimation:(CGFloat)progress;
@end
