//
//  YSInteractiveTransition.h
//  pushDemo
//
//  Created by Onion on 2019/4/17.
//  Copyright © 2019 Onion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (void)wireToViewController:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
