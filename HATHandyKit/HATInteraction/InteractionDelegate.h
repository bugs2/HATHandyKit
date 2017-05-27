//
//  InteractionDelegate.h
//  TaiYing
//
//  Created by ZC on 16/6/3.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ConfirmActionBlock)();
typedef void(^CancelActionBlock)();

//typedef void(^ActionSheetSelectionBlock)(NSInteger buttonIndex);

@interface InteractionDelegate : NSObject<UIAlertViewDelegate>

@property (nonatomic, copy)ConfirmActionBlock confirmActionBlock;
@property (nonatomic, copy)CancelActionBlock cancelActionBlock;

//@property (nonatomic, copy)ActionSheetSelectionBlock actionSheetSelectionBlock;

- (instancetype)initWithConfirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock;

//- (instancetype)initWithActionSheetSelectionBlock:(ActionSheetSelectionBlock)actionSheetSelectionBlock;



@end
