
//
//  HATPatternLockItem.m
//  PatternLockDemo
//
//  Created by ZC on 2017/2/16.
//  Copyright © 2017年 Hikvision. All rights reserved.
//

#import "HATPatternLockItem.h"

#define ITEMRADIUS_OUTTER    70  //item的外圆直径
#define ITEMRADIUS_INNER     20  //item的内圆直径
#define ITEMRADIUS_LINEWIDTH 1   //item的线宽

@interface HATPatternLockItem ()

@property (strong, nonatomic) CAShapeLayer *outterLayer;  // 填充Layer
@property (strong, nonatomic) CAShapeLayer *innerLayer;   // 触控响应Layer
@property (strong, nonatomic) CAShapeLayer *triangleLayer;// 方向响应Layer

@end

@implementation HATPatternLockItem

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

#pragma mark - Getter
- (CAShapeLayer *)innerLayer {
    
    if (!_innerLayer) {
        _innerLayer = [CAShapeLayer layer];
        _innerLayer.frame = CGRectMake((self.frame.size.width - ITEMRADIUS_INNER)/2, (self.frame.size.width - ITEMRADIUS_INNER) / 2, ITEMRADIUS_INNER, ITEMRADIUS_INNER);
        _innerLayer.fillColor = [UIColor clearColor].CGColor;
        
        UIBezierPath *innerLayer = [UIBezierPath bezierPathWithOvalInRect:self.innerLayer.bounds];
        _innerLayer.path = innerLayer.CGPath;
        
    }
    
    return _innerLayer;
}

- (CAShapeLayer *)outterLayer {
    
    if (!_outterLayer) {
        _outterLayer = [CAShapeLayer layer];
        _outterLayer.frame = CGRectMake((self.frame.size.width - ITEMRADIUS_OUTTER) / 2, (self.frame.size.width - ITEMRADIUS_OUTTER) / 2, ITEMRADIUS_OUTTER, ITEMRADIUS_OUTTER);
        _outterLayer.fillColor = self.fillColor.CGColor;
        _outterLayer.strokeColor =  kColor999.CGColor;//
        _outterLayer.lineWidth = ITEMRADIUS_LINEWIDTH;
        
        UIBezierPath *outterLayer = [UIBezierPath bezierPathWithOvalInRect:self.outterLayer.bounds];
        _outterLayer.path = outterLayer.CGPath;
        
    }
    
    return _outterLayer;
}

- (CAShapeLayer *)triangleLayer {
    
    if (!_triangleLayer) {
        _triangleLayer = [CAShapeLayer layer];
        _triangleLayer.frame = CGRectZero;
        _triangleLayer.fillColor = self.triangleLayerColor.CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(self.frame.size.width / 2, self.innerLayer.frame.origin.y-10)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2 - 5, self.innerLayer.frame.origin.y - 3)];
        [path addLineToPoint:CGPointMake(self.frame.size.width / 2 + 5, self.innerLayer.frame.origin.y - 3)];
        _triangleLayer.path = path.CGPath;
    }
    
    return _triangleLayer;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [UIColor colorWithRed:0.13 green:0.7 blue:0.96 alpha:1];
    }
    return _selectedColor;
}

#pragma mark - Setter
- (void)setItemStyle:(HATPatternLockItemStyle)itemStyle {
    switch (itemStyle) {
        case HATPatternLockItemStyleNormal:
            [self normalStyle];
            break;
            
        case HATPatternLockItemStyleSelected:
            [self selectedStyle];
            break;
            
        case HATPatternLockItemStyleWrong:
            [self wrongStyle];
            break;
            
        default:
            break;
    }
}

- (void)setFillColor:(UIColor *)fillColor {
    if (_fillColor != fillColor) {
        _fillColor = fillColor;
        self.outterLayer.fillColor = _fillColor.CGColor;
    }
}

- (void)setTriangleLayerColor:(UIColor *)triangleLayerColor {
    if (_triangleLayerColor != triangleLayerColor) {
        _triangleLayerColor = triangleLayerColor;
        self.triangleLayer.fillColor = self.triangleLayerColor.CGColor;
    }
}

#pragma mark - Private

- (void)initSubViews {
    [self.layer addSublayer:self.outterLayer];
    [self.layer addSublayer:self.innerLayer];
    [self.layer addSublayer:self.triangleLayer];
    self.triangleLayer.hidden = YES;
}

- (void)normalStyle {
    self.innerLayer.fillColor    = [UIColor clearColor].CGColor;
    self.outterLayer.strokeColor = kColor999.CGColor;
    self.outterLayer.fillColor = [UIColor clearColor].CGColor;
}

- (void)selectedStyle {
    self.innerLayer.fillColor    = self.selectedColor.CGColor;
    self.outterLayer.strokeColor = [kColorBrandBlue colorWithAlphaComponent:0.4].CGColor;
    self.outterLayer.fillColor = [kColorBrandBlue colorWithAlphaComponent:0.2].CGColor;
}

- (void)wrongStyle {
    self.innerLayer.fillColor    = kColorBrandRed.CGColor;
    self.outterLayer.strokeColor = [kColorBrandRed colorWithAlphaComponent:0.4].CGColor;
    self.outterLayer.fillColor =   [kColorBrandRed colorWithAlphaComponent:0.2].CGColor;
}

#pragma mark - Public
- (void)showDirectionWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint shouldHidden:(BOOL)shouldHidden {
    
    if (shouldHidden) {
        self.triangleLayer.hidden = YES;
        return;
    }
    
    CGFloat x1 = startPoint.x;
    CGFloat y1 = startPoint.y;
    CGFloat x2 = endPoint.x;
    CGFloat y2 = endPoint.y;
    
    if (x1 == x2 && y1 == y2) {
        return;
    }
    
    if (x1 == 0 && y1 == 0) {
        return;
    }
    
    if (x2 == 0 && y2 == 0) {
        return;
    }
    
    if (self.triangleLayer.hidden == NO) {
        return;
    }
    
    self.triangleLayer.hidden = NO;
    CGFloat angle ;
    
    if (x1 < x2 && y1 > y2) {
        // 左上
        angle = M_PI_4;
        
    } else if (x1 < x2 && y1 == y2) {
        // 左
        angle = M_PI_2;
        
    } else if (x1 < x2 && y1 < y2) {
        // 左下
        angle = M_PI_4 * 3;
        
    } else if (x1 == x2 && y1 < y2) {
        // 下
        angle = M_PI;
        
    } else if (x1 > x2 && y1 < y2) {
        // 右下
        angle = -M_PI_4 * 3;
        
    } else if (x1 > x2 && y1 == y2) {
        // 右
        angle = - M_PI_2;
        
    } else if (x1>x2 && y1>y2) {
        // 右上
        angle = - M_PI_4 *3 ;
        
    } else {
        angle = .0f;
    }

    self.transform = CGAffineTransformMakeRotation(angle);
}

@end
