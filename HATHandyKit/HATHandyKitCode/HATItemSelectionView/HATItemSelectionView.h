//
//  TopSelectionView.h
//  AutoMobile
//
//  Created by ZC on 16/7/29.
//  Copyright © 2016年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSelectedItemHeight 2.5

typedef void(^CurrentIndexBlock)(NSUInteger currentIndex);   // 返回当前选中的菜单Index

@interface HATItemSelectionView : UIView

@property (nonatomic, assign) NSUInteger itemsCount;    // 菜单项个数

@property (nonatomic, strong) NSArray *itemTitles;      // 菜单项名称数组

@property (nonatomic, copy) CurrentIndexBlock currentIndexBlock;   // Block返回当前选中的菜单Index，仅点击事件触发

@property (nonatomic, assign) NSUInteger currentItemIndex;// 当前选中菜单项index

@property (nonatomic, strong) UIImageView *selectedImageView;// 选中标志

@property (nonatomic, assign) CGFloat height;           // 视图高

@property (nonatomic, assign) CGFloat width;            // 视图宽

@property (nonatomic, assign) CGFloat itemHeight;       // 菜单项高

@property (nonatomic, assign) CGFloat itemWidth;        // 菜单项宽

@property (nonatomic, assign) UIButton *selectedButton; // 当前选中的Button

/**
 *  初始化方法
 *
 *  @param titleArray 菜单项名称数组
 *  @param frame      菜单视图frame
 *
 *  @return TopSelectionView实例
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray frame:(CGRect)frame;

/**
 *  手动点击Item
 *
 *  @param index 点击菜单项index
 */
- (void)touchItemWithIndex:(NSUInteger)index;


@end
