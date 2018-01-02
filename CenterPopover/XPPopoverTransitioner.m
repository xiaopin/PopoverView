//
//  XPPopoverTransitioner.m
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "XPPopoverTransitioner.h"
#import "XPPopoverPresentationController.h"

@implementation XPPopoverAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    BOOL isPresentation = [self isPresentation];
    
    if(isPresentation) {
        [containerView addSubview:toView];
    }
    
    UIViewController *animatingVC = isPresentation? toVC : fromVC;
    UIView *animatingView = [animatingVC view];
    
    [animatingView setFrame:[transitionContext finalFrameForViewController:animatingVC]];
    
    CGAffineTransform presentedTransform = CGAffineTransformIdentity;
    CGAffineTransform dismissedTransform = CGAffineTransformMakeScale(0.001, 0.001);
    
    [animatingView setTransform:isPresentation ? dismissedTransform : presentedTransform];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         animatingView.transform = isPresentation ? presentedTransform : dismissedTransform;
                     } completion:^(BOOL finished) {
                         if (![self isPresentation]) {
                             [fromView removeFromSuperview];
                         }
                         [transitionContext completeTransition:YES];
                     }];
}

@end

#pragma mark -

@implementation XPPopoverTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[XPPopoverPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (XPPopoverAnimatedTransitioning *)animationController {
    XPPopoverAnimatedTransitioning *animationController = [[XPPopoverAnimatedTransitioning alloc] init];
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    XPPopoverAnimatedTransitioning *animationController = [self animationController];
    [animationController setPresentation:YES];
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    XPPopoverAnimatedTransitioning *animationController = [self animationController];
    [animationController setPresentation:NO];
    return animationController;
}

@end
