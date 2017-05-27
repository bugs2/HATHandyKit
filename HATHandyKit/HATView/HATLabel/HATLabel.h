//
//  HATLabel.h
//  TBox
//
//  Created by jiangwei9 on 13/03/2017.
//  Copyright © 2017 Hikvison AutoMotive Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface HATLabel : UILabel

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;


@end
