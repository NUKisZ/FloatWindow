//
//  ELCommonHelper.m
//  ELive
//
//  Created by zhangk on 2017/6/19.
//  Copyright © 2017年 zhangk. All rights reserved.
//

#import "ELCommonHelper.h"

@implementation ELCommonHelper

+ (void)forceOrientation: (UIInterfaceOrientation)orientation {
    CGFloat width = kScreenHeight>kScreenWidth? kScreenWidth:kScreenHeight;
    CGFloat height = kScreenHeight>kScreenWidth? kScreenHeight:kScreenWidth;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if(appDelegate.win){
        [appDelegate.win resignKeyWindow];
        appDelegate.win = nil;
    }
    if(appDelegate.orientaionType == UIDeviceOrientationTypePortraitLock){
        appDelegate.win = [[AssistiveTouch alloc]initWithFrame:CGRectMake(width-20, height-100, width/2, 40)];
    }else{
        appDelegate.win = [[AssistiveTouch alloc]initWithFrame:CGRectMake(height-20, width-100, height/2, 40)];
        
    }
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget: [UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
