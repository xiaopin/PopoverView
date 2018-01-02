//
//  XPPopoverTransitioner.h
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_CLASS_AVAILABLE_IOS(8_0) @interface XPPopoverAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter=isPresentation) BOOL presentation;

@end



NS_CLASS_AVAILABLE_IOS(8_0) @interface XPPopoverTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@end
