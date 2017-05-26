//
//  YTKAnimatingRequestAccessory.m
//  Ape_uni
//
//  Created by Chenyu Lan on 10/30/14.
//  Copyright (c) 2014 Fenbi. All rights reserved.
//

#import "YTKAnimatingRequestAccessory.h"
#import "MBProgressHUD.h"

//#import "YTKAlertUtils.h"


@implementation YTKAnimatingRequestAccessory

- (id)initWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
        _animatingText = animatingText;
    }
    return self;
}

- (id)initWithAnimatingView:(UIView *)animatingView {
    self = [super init];
    if (self) {
        _animatingView = animatingView;
    }
    return self;
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView {
    return [[self alloc] initWithAnimatingView:animatingView];
}

+ (id)accessoryWithAnimatingView:(UIView *)animatingView animatingText:(NSString *)animatingText {
    return [[self alloc] initWithAnimatingView:animatingView animatingText:animatingText];
}

- (void)requestWillStart:(id)request {
    if (_animatingView || _animatingText) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // TODO: show loading
            // [YTKAlertUtils showLoadingAlertView:_animatingText inView:_animatingView];
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            _loadingView = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
            _loadingView.minShowTime = 0.25;
            _loadingView.contentColor = [UIColor whiteColor];
            _loadingView.mode = MBProgressHUDModeText;
            _loadingView.label.text = _animatingText;
            _loadingView.label.numberOfLines = 0;
            _loadingView.label.font = [UIFont boldSystemFontOfSize:14];
            _loadingView.margin = kMessageView_TopMargin;
            _loadingView.bezelView.layer.cornerRadius = kMessageView_Corneradios;
            //_loadingView.bezelView.backgroundColor = kColorToastColor;
            _loadingView.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
            _loadingView.bezelView.color = kColorToastColor;
        });
    }
}

- (void)requestWillStop:(id)request {
    if (_animatingView || _animatingText) {
        // TODO: hide loading
        //[YTKAlertUtils hideLoadingAlertView:_animatingView];
        NSLog(@" loading finished");
        [_loadingView hideAnimated:YES];
    }
}

@end
