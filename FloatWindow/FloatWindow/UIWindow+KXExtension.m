//
//  UIWindow+KXExtension.m
//  KXCategory
//
//  Created by zhangk on 2017/5/5.
//  Copyright © 2017年 zhangk. All rights reserved.
//

#import "UIWindow+KXExtension.h"

@implementation UIWindow (KXExtension)
// 获取窗口最上级的视图控制器
- (UIViewController *)kx_topMostViewController{
    UIViewController *topVC = self.rootViewController;
    
    while ([topVC presentedViewController]) {
        topVC = [topVC presentedViewController];
    }
    
    return topVC;
}

// 获取窗口上正在显示的视图控制器
- (UIViewController *)kx_currentViewController{
    UIViewController *currentVC = [self kx_topMostViewController];
    
    while ([currentVC isKindOfClass:[UINavigationController class]] && [(UINavigationController *)currentVC topViewController]) {
        currentVC = [(UINavigationController *)currentVC topViewController];
    }
    
    return currentVC;
}
@end
