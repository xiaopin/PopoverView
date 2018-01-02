//
//  XPPopoverPresentationController.h
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPPopoverPresentationController : UIPresentationController

/// default `YES`.
@property (nonatomic, assign, getter=isShouldDismissPopover) BOOL shouldDismissPopover;

@end
