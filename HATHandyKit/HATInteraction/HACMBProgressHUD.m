//
//  HACMBProgressHUD.m
//  Pods
//
//  Created by jiangwei9 on 27/05/2017.
//
//

#import "HACMBProgressHUD.h"

@implementation HACMBProgressHUD

- (void)setLeftMargin:(CGFloat)margin {
    if (margin != _leftMargin) {
        _leftMargin = margin;
        [self setNeedsUpdateConstraints];
    }
}

- (void)updateConstraints {
    [super updateConstraints];
    
    
    for (NSLayoutConstraint *constrant in self.bezelView.constraints) {
        NSLayoutAttribute attribute1 = constrant.firstAttribute;
        NSLayoutAttribute attribute2 = constrant.secondAttribute;
        
        if ((attribute1 == attribute2) && (attribute1 == NSLayoutAttributeLeading || attribute1 == NSLayoutAttributeTrailing)) {
            constrant.constant = self.leftMargin;
        }
    }
}

@end
