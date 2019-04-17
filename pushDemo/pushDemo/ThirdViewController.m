//
//  ThirdViewController.m
//  pushDemo
//
//  Created by Onion on 2019/4/16.
//  Copyright © 2019 Onion. All rights reserved.
//

#import "ThirdViewController.h"
#import "SecondViewController.h"
#import "YSPresentAnimation.h"
#import "YSDismissAnimation.h"
#import "YSInteractiveTransition.h"
#import "YSBGView.h"
@interface ThirdViewController ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) YSPresentAnimation *presentAnimation;
@property (nonatomic, strong) YSDismissAnimation *dismissAnimation;
@property (nonatomic, strong) YSInteractiveTransition *interactiveTransition;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试";
    self.view.backgroundColor = [UIColor cyanColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"第二页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    self.presentAnimation = [[YSPresentAnimation alloc] init];
    self.dismissAnimation = [[YSDismissAnimation alloc] init];
    self.interactiveTransition = [[YSInteractiveTransition alloc] init];
}
- (void)buttonClicked:(id)sender {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.transitioningDelegate = self;
    secondVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.interactiveTransition wireToViewController:secondVC];
    [self presentViewController:secondVC animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self.presentAnimation;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.dismissAnimation;
}
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.interactiveTransition.interacting ? self.interactiveTransition : nil;
}
@end
