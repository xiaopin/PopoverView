//
//  ContentViewController.m
//  Example
//
//  Created by nhope on 2017/12/29.
//  Copyright © 2017年 nhope. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0
                                                green:arc4random()%256/255.0
                                                 blue:arc4random()%256/255.0
                                                alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
