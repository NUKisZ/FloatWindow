//
//  UIWindow+KXExtension.h
//  KXCategory
//
//  Created by zhangk on 2017/5/5.
//  Copyright © 2017年 zhangk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (KXExtension)
// 获取窗口最上级的视图控制器
- (UIViewController *)kx_topMostViewController;

// 获取窗口上正在显示的视图控制器
- (UIViewController *)kx_currentViewController;

@end
