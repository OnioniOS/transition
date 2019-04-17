//
//  YSPresentAnimation.m
//  pushDemo
//
//  Created by Onion on 2019/4/16.
//  Copyright © 2019 Onion. All rights reserved.
//

#import "YSPresentAnimation.h"
#import "YSBGView.h"
@implementation YSPresentAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    YSBGView *bgView = [[YSBGView alloc] initWithFrame:fromVC.view.frame];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.3;
    [fromVC.view addSubview:bgView];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *fromSnapView = [fromView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:fromSnapView];
    [[transitionContext containerView] addSubview:toView];
    CGRect mainRect = [UIScreen mainScreen].bounds;
    toView.frame = CGRectMake(0, mainRect.size.height, mainRect.size.width, mainRect.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, PRESENTINGVIEW_Y, mainRect.size.width, mainRect.size.height);
    } completion:^(BOOL finished) {
        [transitionContext containerView].backgroundColor = containerViewColor;
        [fromSnapView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
