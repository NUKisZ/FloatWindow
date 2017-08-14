//
//  SecondViewController.m
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import "SecondViewController.h"
#import "AssistiveTouchCollectionViewCell.h"
static NSString *collectionViewCellId = @"collectionViewCellId";
@interface SecondViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:kAssistiveTouchNotificationCenter object:nil];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.orientaionType = UIDeviceOrientationTypeLandRightLock;
    [ELCommonHelper forceOrientation:UIInterfaceOrientationLandscapeRight];
    self.navigationController.title = @"测试";
    self.title = @"第二页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    //[self.view addSubview:self.collection];
    
    //[self.view addSubview:self.tableView];
    
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
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
    NSLog(@"SecondViewController%@",not.object);
}
-(void)dealloc{
    NSLog(@"SecondViewController---------dealloc");
}
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AssistiveTouchCollectionViewCell *cell = (AssistiveTouchCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellId forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.titleString = @"资讯";
            break;
        case 1:
            cell.titleString = @"积分游戏";
            break;
        case 2:
            cell.titleString = @"门票";
            break;
        case 3:
            cell.titleString = @"周边";
            break;
        case 4:
            cell.titleString = @"专辑";
            break;
        case 5:
            cell.titleString = @"点歌";
            break;
        default:
            break;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *indexString = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"%@",indexString);
    //[[NSNotificationCenter defaultCenter]postNotificationName:kAssistiveTouchNotificationCenter object:indexString];
    
}
-(UICollectionView *)collection{
    if(!_collection){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.automaticallyAdjustsScrollViewInsets = NO;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.itemSize = CGSizeMake(50, 40);
        layout.minimumLineSpacing=10;
        layout.minimumInteritemSpacing=10;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 5);
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 100, 100, 50) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        [_collection registerClass:[AssistiveTouchCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellId];
        
    }
    return _collection;
}
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 375, 550) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate= self;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
