//
//  UIViewController+CenterPopover.m
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import "UIViewController+CenterPopover.h"
#import "XPPopoverPresentationController.h"
#import "XPPopoverTransitioner.h"
#import <objc/runtime.h>


@implementation UIViewController (CenterPopover)

- (void)presentPopoverPresentationController:(UIViewController *)contentViewController preferredContentSize:(CGSize)preferredContentSize shouldDismissPopover:(BOOL)shouldDismissPopover completion:(void (^)(void))completion {
    if (self.presentedViewController) { return; }
    contentViewController.modalPresentationStyle = UIModalPresentationCustom;
    contentViewController.preferredContentSize = preferredContentSize;
    
    XPPopoverTransitioningDelegate *transitioningDelegate = [[XPPopoverTransitioningDelegate alloc] init];
    contentViewController.transitioningDelegate = transitioningDelegate;
    // Keep strong references.
    static char delegateKey;
    objc_setAssociatedObject(contentViewController, &delegateKey, transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    XPPopoverPresentationController *presentationController = (XPPopoverPresentationController *)contentViewController.presentationController;
    presentationController.shouldDismissPopover = shouldDismissPopover;
    
    [self presentViewController:contentViewController animated:YES completion:completion];
}

- (void)presentPopoverView:(UIView *)contentView preferredContentSize:(CGSize)preferredContentSize shouldDismissPopover:(BOOL)shouldDismissPopover completion:(void (^)(void))completion {
    NSAssert(contentView, @"The contentView cann't be nil.");
    UIViewController *contentViewController = [[UIViewController alloc] init];
    contentViewController.view.backgroundColor = [UIColor clearColor];
    [contentViewController.view addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    
    [self presentPopoverPresentationController:contentViewController preferredContentSize:preferredContentSize shouldDismissPopover:shouldDismissPopover completion:completion];
}

@end
