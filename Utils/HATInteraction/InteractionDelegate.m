//
//  InteractionDelegate.m
//  TaiYing
//
//  Created by ZC on 16/6/3.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

#import "InteractionDelegate.h"

@implementation InteractionDelegate

- (instancetype)initWithConfirmActionBlock:(ConfirmActionBlock)confirmActionBlock cancelActionBlock:(CancelActionBlock)cancelActionBlock {
    if (self = [super init]) {
        self.confirmActionBlock = confirmActionBlock;
        self.cancelActionBlock = cancelActionBlock;
    }
    return self;
}
/*
- (instancetype)initWithActionSheetSelectionBlock:(ActionSheetSelectionBlock)actionSheetSelectionBlock {
    if (self = [super init]) {
        self.actionSheetSelectionBlock = actionSheetSelectionBlock;
    }
    return self;
}
*/

#pragma mark - UIAlertViewDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    
}

// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0) {
    
}

- (void)willPresentAlertView:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0) {
    
}  // before animation and showing view

- (void)didPresentAlertView:(UIAlertView *)alertView NS_DEPRECATED_IOS(2_0, 9_0) {
    
}  // after animation

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    if (buttonIndex == 0) {
        if (self.confirmActionBlock) {
            self.confirmActionBlock();
        }
    } else {
        if (self.cancelActionBlock) {
            self.cancelActionBlock();
        }
    }
} // before animation and hiding view

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    
}  // after animation

/*
#pragma mark - TBActionSheetDelegate
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(TBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.actionSheetSelectionBlock) {
        self.actionSheetSelectionBlock(buttonIndex);
    }
}
// Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
// If not defined in the delegate, we simulate a click in the cancel button
- (void)actionSheetCancel:(TBActionSheet *)actionSheet {

}
// before animation and showing view
- (void)willPresentActionSheet:(TBActionSheet *)actionSheet {

}
// after animation
- (void)didPresentActionSheet:(TBActionSheet *)actionSheet {

}
// before animation and hiding view
- (void)actionSheet:(TBActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {

}
// after animation
- (void)actionSheet:(TBActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {

}
 */

@end
