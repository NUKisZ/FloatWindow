//
//  AppDelegate.h
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssistiveTouch.h"
#define kScreenWidth [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight [[UIScreen mainScreen]bounds].size.height
typedef NS_ENUM(NSInteger, UIDeviceOrientationType){
    UIDeviceOrientationTypePortraitLock,//锁定竖屏
    UIDeviceOrientationTypePortraitUnLock,//自动竖屏
    UIDeviceOrientationTypeLandRightLock, //横屏锁定
    UIDeviceOrientationTypeLandRightUnLock //自动
};

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) UIDeviceOrientationType orientaionType;
@property (nonatomic, strong) AssistiveTouch *win;

@end

