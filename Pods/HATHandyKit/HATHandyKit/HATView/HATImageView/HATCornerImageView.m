//
//  HATCornerImageView.m
//  TBox
//
//  Created by jiangwei9 on 09/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import "HATCornerImageView.h"

@implementation HATCornerImageView

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius  = _cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
