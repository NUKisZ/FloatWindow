//
//  AssistiveTouch.m
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import "AssistiveTouch.h"
#import "AssistiveTouchCollectionViewCell.h"
static NSString *collectionViewCellId = @"collectionViewCellId";
@interface AssistiveTouch()<UICollectionViewDelegate,UICollectionViewDataSource,AssistiveTouchCollectionViewCellDelegate>{
    UIButton *_button;
}
@property (nonatomic, strong) UIView *touchView;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) BOOL isShow2;

@property (nonatomic, strong) UICollectionView *collection;

@end

@implementation AssistiveTouch

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert-1;
        self.rootViewController = [UIViewController new];
        self.rootViewController.view.backgroundColor = [UIColor clearColor];
        [self makeKeyAndVisible];
        self.touchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.touchView.layer.cornerRadius = 5;
        self.touchView.layer.masksToBounds = YES;
        self.touchView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchClick)];
        [self.touchView addGestureRecognizer:tap];
        [self addSubview:self.touchView];
        [self.touchView addSubview:self.collection];
        self.collection.hidden = YES;
        [[NSNotificationCenter defaultCenter]postNotificationName:kAssistiveTouchNotificationCenter object:@"a"];
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changePostion:)];
//        [self.touchView addGestureRecognizer:pan];
    }
    return self;
}
- (void)touchClick{
    //CGFloat width = kScreenHeight>kScreenWidth? kScreenWidth:kScreenHeight;
    CGFloat height = kScreenHeight>kScreenWidth? kScreenHeight:kScreenWidth;
    AppDelegate *delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
    if(delegate.orientaionType == UIDeviceOrientationTypeLandRightLock){
        if(self.isShow2 == NO){
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.origin.x = height/2;
                self.frame = frame;
                self.collection.hidden = NO;
            } completion:^(BOOL finished) {
                self.isShow2 = YES;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.origin.x = height-20;
                self.frame = frame;
                
            } completion:^(BOOL finished) {
                self.isShow2 = NO;
                self.collection.hidden = YES;
            }];
        }
    }else{
        if(self.isShow == NO){
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.origin.x = self.frame.size.width;
                self.frame = frame;
                self.collection.hidden = NO;
            } completion:^(BOOL finished) {
                self.isShow = YES;
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                CGRect frame = self.frame;
                frame.origin.x = 355;
                self.frame = frame;
                
            } completion:^(BOOL finished) {
                self.isShow = NO;
                self.collection.hidden = YES;
            }];
        }
    }
    
    
    NSLog(@"touchUpInside");
}
-(void)changePostion:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame =self.frame;
    
    if(originalFrame.origin.x>=0&& originalFrame.origin.x+originalFrame.size.width<= width) {
        
        originalFrame.origin.x+= point.x;
        
    }
    
    if(originalFrame.origin.y>=0&& originalFrame.origin.y+originalFrame.size.height<= height) {
        
        originalFrame.origin.y+= point.y;
        
    }
    
    self.frame= originalFrame;
    [pan setTranslation:CGPointZero inView:self];
    
    if(pan.state==UIGestureRecognizerStateBegan) {
        
        _button.enabled=NO;
        
    }else if(pan.state==UIGestureRecognizerStateChanged){
        
    }else{
        
        CGRect frame =self.frame;
        
        //记录是否越界
        
        BOOL isOver =NO;
        
        if(frame.origin.x<0) {
            
            frame.origin.x=0;
            
            isOver =YES;
            
        }else if(frame.origin.x+frame.size.width> width) {
            
            frame.origin.x= width - frame.size.width;
            
            isOver =YES;
            
        }
        
        if(frame.origin.y<0) {
            
            frame.origin.y=0;
            
            isOver =YES;
            
        }else if(frame.origin.y+frame.size.height> height) {
            
            frame.origin.y= height - frame.size.height;
            
            isOver =YES;
            
        }
        
        if(isOver) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame= frame;
                
            }];
            
        }
        
        _button.enabled=YES;
        
    }
    
    
}

#pragma mark - AssistiveTouchCollectionViewCellDelegate
- (void)AssistiveTouchCollectionViewCell:(AssistiveTouchCollectionViewCell *)cell index:(NSUInteger)index{
    NSLog(@"titleString-------%@",cell.titleString);
    NSLog(@"------%ld",index);
    
    NSString *indexString = [NSString stringWithFormat:@"%ld",index];
    [[NSNotificationCenter defaultCenter]postNotificationName:kAssistiveTouchNotificationCenter object:indexString];
    [self performSelector:@selector(touchClick) withObject:nil];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    AssistiveTouchCollectionViewCell *cell = (AssistiveTouchCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellId forIndexPath:indexPath];
    
    
    cell.index = indexPath.row;
    cell.delegate = self;
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

-(UICollectionView *)collection{
    if(!_collection){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        AppDelegate *delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
//        if(delegate.orientaionType == UIDeviceOrientationLandscapeLeft){
//            [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        }else{
//            [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        }
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.itemSize = CGSizeMake(50, 40);
        layout.minimumLineSpacing=10;
        layout.minimumInteritemSpacing=10;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 5);
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        [_collection registerClass:[AssistiveTouchCollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellId];
        
    }
    return _collection;
}

@end
