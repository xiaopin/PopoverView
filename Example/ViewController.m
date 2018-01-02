//
//  ViewController.m
//  Example
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+CenterPopover.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Popover" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0].active = YES;
}


- (void)buttonAction:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    [self presentPopoverPresentationController:vc preferredContentSize:CGSizeMake(200.0, 300.0) shouldDismissPopover:NO completion:^{
        NSLog(@"Popover show finish.");
    }];
    

//    UIView *contentView = [[UIView alloc] init];
//    contentView.backgroundColor = [UIColor purpleColor];
//    [self presentPopoverView:contentView preferredContentSize:CGSizeMake(200.0, 300.0) shouldDismissPopover:YES completion:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
//        });
//    }];
}


@end
