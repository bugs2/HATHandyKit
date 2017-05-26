//
//  UIView+Additions.h
//  PageViewController
//
//  Created by user6 on 15/12/14.
//  Copyright © 2015年 zyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (id) initWithParent:(UIView *)parent;
+ (id) viewWithParent:(UIView *)parent;
- (void)removeAllSubViews;
- (UIViewController*)viewController;

@property CGPoint position;
@property CGFloat x;
@property CGFloat y;
@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;
@property BOOL	visible;
@property CGSize size;
@property CGFloat width;
@property CGFloat height;

@end

@interface UIImageView (MFAdditions)

- (void) setImageWithName:(NSString *)name;

@end
