//
//  UIViewController+CenterPopover.h
//  https://github.com/xiaopin/PopoverView.git
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 Demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CenterPopover)

/**
 显示一个居中Popover视图控制器
 
 @param contentViewController   弹窗视图控制器
 @param preferredContentSize    弹窗大小
 @param shouldDismissPopover    当点击弹窗内容之外的区域时是否关闭弹窗
 @param completion              回调
 */
- (void)presentPopoverPresentationController:(UIViewController *)contentViewController preferredContentSize:(CGSize)preferredContentSize shouldDismissPopover:(BOOL)shouldDismissPopover completion:(void (^)(void))completion NS_AVAILABLE_IOS(8_0);



/**
 显示一个居中Popover视图
 
 内部会创建一个UIViewController并将contentView添加到该控制器的view上,并且设置约束为`距离父视图上下左右均为0`的约束.
 如果需要手动关闭Popover,则`谁弹出谁负责关闭`,即`[self.presentedViewController dismissViewControllerAnimated:YES completion:nil]`

 @param contentView             弹窗视图
 @param preferredContentSize    弹窗大小
 @param shouldDismissPopover    当点击弹窗内容之外的区域时是否关闭弹窗
 @param completion              回调
 */
- (void)presentPopoverView:(UIView *)contentView preferredContentSize:(CGSize)preferredContentSize shouldDismissPopover:(BOOL)shouldDismissPopover completion:(void (^)(void))completion NS_AVAILABLE_IOS(8_0);

@end
