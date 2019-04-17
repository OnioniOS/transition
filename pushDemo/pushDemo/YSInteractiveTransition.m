//
//  YSInteractiveTransition.m
//  pushDemo
//
//  Created by Onion on 2019/4/17.
//  Copyright © 2019 Onion. All rights reserved.
//

#import "YSInteractiveTransition.h"
#import "YSBGView.h"

@interface YSInteractiveTransition ()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;
@end

@implementation YSInteractiveTransition
- (void)wireToViewController:(UIViewController*)viewController {
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (CGFloat)completionSpeed {
    return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
        case UIGestureRecognizerStateChanged: {
            CGFloat totalY = PRESENTINGVIEW_Y;
            CGFloat fraction = translation.y / totalY;
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.3);//滑动比例
            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}

@end
