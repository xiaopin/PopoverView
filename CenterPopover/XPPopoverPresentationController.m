//
//  XPPopoverPresentationController.m
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "XPPopoverPresentationController.h"

@interface XPPopoverPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation XPPopoverPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _shouldDismissPopover = YES;
        _dimmingView = [[UIView alloc] init];
        _dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
        [_dimmingView addGestureRecognizer:tapGesture];
    }
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView {
    CGSize containerSize = self.containerView.bounds.size;
    CGRect presentedViewFrame = CGRectZero;
    CGFloat width = MIN(containerSize.width, self.presentedViewController.preferredContentSize.width);
    CGFloat height = MIN(containerSize.height, self.presentedViewController.preferredContentSize.height);

    presentedViewFrame.size = CGSizeMake(width, height);
    presentedViewFrame.origin = CGPointMake(containerSize.width/2, containerSize.height/2);
    presentedViewFrame.origin.x -= presentedViewFrame.size.width/2;
    presentedViewFrame.origin.y -= presentedViewFrame.size.height/2;
    return presentedViewFrame;
}

- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    
    // Add our chrome to the dimming view
    [self.containerView addSubview:self.dimmingView];
    
    // Before the presentation begins, we want to have our dimming view be totally transparent
    self.dimmingView.alpha = 0.0;
    
    // Alongside the view controller presentation animation, we want to fade the dimming view to
    // be opaque. We can do so by animating alongside the current transition on the presented
    // view controller
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 1.0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews {
    self.dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

- (void)dismissalTransitionWillBegin {
    [super dismissalTransitionWillBegin];
    
    // In -dismissalTransitionWillBegin, we want to undo what we did in
    // -presentationTransitionWillBegin. Fade our dimming view's alpha back to 0
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.0;
    } completion:nil];
}

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    if (self.shouldDismissPopover) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
