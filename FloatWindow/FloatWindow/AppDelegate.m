//
//  AppDelegate.m
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"




@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    self.window.backgroundColor = [UIColor greenColor];
    self.window.rootViewController = nvc;
    [self performSelector:@selector(setNew) withObject:nil afterDelay:1];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)deviceOrientationDidChange:(NSNotification *)note{
    //1.获取 当前设备 实例
    UIDevice *device = [UIDevice currentDevice] ;
    
    /**
     *  2.取得当前Device的方向，Device的方向类型为Integer
     *
     *  必须调用beginGeneratingDeviceOrientationNotifications方法后，此orientation属性才有效，否则一直是0。orientation用于判断设备的朝向，与应用UI方向无关
     *
     *  @param device.orientation
     *
     */
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
        case UIInterfaceOrientationUnknown:
            NSLog(@"未知方向");
            break;
        case UIInterfaceOrientationLandscapeRight:
            
            self.orientaionType = UIDeviceOrientationTypeLandRightLock;
            if(self.win){
                [self.win resignKeyWindow];
                self.win = nil;
            }
            [self performSelector:@selector(setNew) withObject:nil afterDelay:1];
            break;
            
            
        case UIInterfaceOrientationPortrait:
            if(self.win){
                [self.win resignKeyWindow];
                self.win = nil;
            }
            self.orientaionType = UIDeviceOrientationTypePortraitLock;
            [self performSelector:@selector(setNew) withObject:nil afterDelay:1];
            
            break;
            
        default:
            NSLog(@"无法辨识");
            break;
    }
}
- (void)setNew{
    
//    CGFloat width = kScreenHeight>kScreenWidth? kScreenWidth:kScreenHeight;
//    CGFloat height = kScreenHeight>kScreenWidth? kScreenHeight:kScreenWidth;
//    if(self.orientaionType == UIDeviceOrientationTypePortraitLock){
//        self.win = [[AssistiveTouch alloc]initWithFrame:CGRectMake(width-20, height-100, width/2, 40)];
//    }else{
//        self.win = [[AssistiveTouch alloc]initWithFrame:CGRectMake(height-20, width-100, height/2, 40)];
//
//    }
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if (self.orientaionType==UIDeviceOrientationTypePortraitLock) {
        return UIInterfaceOrientationMaskPortrait;
    }
    else if(self.orientaionType==UIDeviceOrientationTypePortraitUnLock){
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    
    return UIInterfaceOrientationMaskLandscapeRight;
}
@end
