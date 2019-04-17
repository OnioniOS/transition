//
//  YSDismissAnimation.m
//  pushDemo
//
//  Created by Onion on 2019/4/16.
//  Copyright © 2019 Onion. All rights reserved.
//

#import "YSDismissAnimation.h"
#import "YSBGView.h"
@implementation YSDismissAnimation
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;

    UIView *toSnapView = [toView snapshotViewAfterScreenUpdates:NO];
    [[transitionContext containerView] addSubview:toSnapView];
    [[transitionContext containerView] addSubview:fromView];
    CGRect mainRect = [UIScreen mainScreen].bounds;
    fromView.frame = CGRectMake(0, PRESENTINGVIEW_Y, mainRect.size.width, mainRect.size.height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(0, mainRect.size.height, mainRect.size.width, mainRect.size.height);
    } completion:^(BOOL finished) {
        if (!transitionContext.transitionWasCancelled) {
            for (UIView *tempView in toVC.view.subviews) {
                if ([tempView isKindOfClass:YSBGView.class]) {
                    [tempView removeFromSuperview];
                    break;
                }
            }
        }
        [toSnapView removeFromSuperview];
        [transitionContext containerView].backgroundColor = containerViewColor;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
