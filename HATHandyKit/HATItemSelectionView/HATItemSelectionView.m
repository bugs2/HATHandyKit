//
//  TopSelectionView.m
//  AutoMobile
//
//  Created by ZC on 16/7/29.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import "HATItemSelectionView.h"
#import "UIView+Additions.h"
#import "UIImage+Common.h"
#import "UIColor+expanded.h"


#define kColorTextGrey [UIColor colorWithRed:151/255.0 green:152/255.0 blue:153/255.0 alpha:1]
#define kColorBrandBlue [UIColor colorWithHexString:@"0x13a1ed"]
#define kColor999 [UIColor colorWithHexString:@"0x999999"]



@implementation HATItemSelectionView

- (instancetype)initWithTitleArray:(NSArray *)titleArray frame:(CGRect)frame {
    if (self = [super init]) {
        self.itemsCount = titleArray.count;
        self.itemTitles = [NSArray arrayWithArray:titleArray];
        self.frame = frame;
        self.height = frame.size.height;
        self.width = frame.size.width;
        self.itemHeight = frame.size.height - kSelectedItemHeight;
        self.itemWidth = frame.size.width / self.itemsCount;
        self.backgroundColor = [UIColor whiteColor];
        
        [self createSubviews];
    }
    return self;
}

/**
 *  创建子视图
 */
- (void)createSubviews {
    
    // 选中标志
    self.selectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:kColorBrandBlue withFrame:CGRectMake(0, 0, 50, 5)]];
    self.selectedImageView.frame = CGRectMake((self.itemWidth - 50) / 2, self.itemHeight, 50, 2.5);
    [self addSubview:self.selectedImageView];
    
    // 菜单项
    for (int i = 0; i< self.itemsCount; i++) {
        NSString *title = [self.itemTitles objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.itemWidth * i ,0 ,self.itemWidth, self.itemHeight);
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        button.titleLabel.lineBreakMode = NSLineBreakByClipping;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:kColor999 forState:UIControlStateNormal];
        [button setTitleColor:kColorBrandBlue forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self addSubview:button];
        if (i == 0) {
            self.selectedButton = button;
            self.selectedButton.selected = YES;
        }
    }
}

- (void)buttonClick:(UIButton *)sender {
    if (self.selectedButton == sender) {
        return;
    }

    NSUInteger currentIndex = sender.tag - 100;
    
    if (self.currentIndexBlock) {
        self.currentIndexBlock(currentIndex);
    }
    
    self.currentItemIndex = currentIndex;
}

- (void)touchItemWithIndex:(NSUInteger)index {
    if (self.currentItemIndex == index) {
        return;
    }
    
    if (self.currentIndexBlock) {
        self.currentIndexBlock(index);
    }
    
    self.currentItemIndex = index;
}

#pragma mark - getter & setter
-(void)setCurrentItemIndex:(NSUInteger)currentItemIndex {
    UIButton *button = (UIButton *)[self viewWithTag:100 + currentItemIndex];
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    self.selectedButton.selected = YES;
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.selectedImageView.x = self.itemWidth * currentItemIndex + (self.itemWidth - 50) / 2;
//    }];
    self.selectedImageView.x = self.itemWidth * currentItemIndex + (self.itemWidth - 50) / 2;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
