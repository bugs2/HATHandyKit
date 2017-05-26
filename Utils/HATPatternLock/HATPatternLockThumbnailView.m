//
//  HATPatternLockSubItem.m
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import "HATPatternLockThumbnailView.h"

#define SUBITEMWH      12 // 单个圆圈的大小

#define SUBITEMTAG 33

@implementation HATPatternLockThumbnailView

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark - Private
- (void)initSubViews {
    CGFloat viewWidth = self.frame.size.width;
    for (int i=0; i<9; i++) {
        int row        = i / 3 ;
        int column     = i % 3 ;
        CGFloat x_or_y = (viewWidth - 3 * SUBITEMWH) / 4 ;
        CGFloat posX   = x_or_y * (column + 1) + column * SUBITEMWH ;
        CGFloat posY   = x_or_y * (row + 1) + row * SUBITEMWH ;
    
        UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(posX ,posY , SUBITEMWH ,SUBITEMWH)];
        myView.tag = i + SUBITEMTAG;
        [self addSubview:myView];
        
        [self drawCircle:myView color:[UIColor clearColor]];
    }
}

- (void)drawCircle:(UIView *)myView color:(UIColor *)color {
    
    if (color == [UIColor clearColor]) {
        myView.backgroundColor = [UIColor whiteColor];
    } else {
        myView.backgroundColor = color;
    }

    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake( 1 , 1 , SUBITEMWH - 2 , SUBITEMWH - 2);
    shape.fillColor = color.CGColor;
    if (color == [UIColor clearColor]) {
        shape.strokeColor = [UIColor whiteColor].CGColor;
    } else {
        shape.strokeColor = color.CGColor;
    }
    shape.lineWidth = 1;
    myView.layer.mask = shape;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:shape.bounds];
    shape.path = path.CGPath;
}

- (void)drawCleanCircle:(UIView *)myView {
    [self drawCircle:myView color:[UIColor clearColor]];
}

#pragma mark - Public
- (void)drawResultWithPasswordStringArray:(NSArray*)passwordStringArray fillColor:(UIColor *)fillColor {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *indexString = [NSString stringWithFormat:@"%lu", idx];
        if ([passwordStringArray containsObject:indexString]) {
            UIView *myView = (UIView *)[self viewWithTag:(idx + SUBITEMTAG)];
            [self drawCircle:myView color:fillColor];
            [self performSelector:@selector(drawCleanCircle:) withObject:myView afterDelay:1 ];
        }
    }];
}

@end
