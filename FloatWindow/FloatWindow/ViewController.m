//
//  ViewController.m
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "AssistiveTouchCollectionViewCell.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(50, 300, 50, 30);
    [btn setTitle:@"跳" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:kAssistiveTouchNotificationCenter object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.orientaionType = UIDeviceOrientationTypePortraitLock;
    [ELCommonHelper forceOrientation:UIInterfaceOrientationPortrait];
}
- (void)notificationAction:(NSNotification *)not{
    UIWindow *window = [[UIApplication sharedApplication]delegate].window;
    if(self != window.kx_currentViewController){
        NSLog(@"不是");
        return;
    }else{
        if([not.object  isEqual: @"1"]){
            self.title = @"积分游戏";
        }else if([not.object  isEqual: @"2"]){
            self.title = @"门票";
        }else if([not.object  isEqual: @"3"]){
            self.title = @"周边";
        }else if([not.object  isEqual: @"4"]){
            self.title = @"专辑";
        }else if([not.object  isEqual: @"5"]){
            self.title = @"点歌";
        }else if([not.object  isEqual: @"0"]){
            self.title = @"资讯";
        }
        NSLog(@"是");
    }
    NSLog(@"ViewController%@",not.object);
}
-(void)btnClick{
    [self.navigationController pushViewController:[[SecondViewController alloc]init]animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
