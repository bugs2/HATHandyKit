//
//  HATBorderView.h
//  TBox
//
//  Created by jiangwei9 on 20/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

//使用该类添加边框
IB_DESIGNABLE
@interface HATBorderView : UIView
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;
@end
