//
//  UIViewController+LQNoPresent.m
//  RNSwitchAppIcon
//
//  Created by 放心家 on 2019/12/16.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "UIViewController+LQNoPresent.h"
#import <objc/runtime.h>

@implementation UIViewController (LQNoPresent)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(lq_presentViewController:animated:completion:));
        
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}


- (void)lq_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
    }
    
    [self lq_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
