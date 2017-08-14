//
//  AssistiveTouchCollectionViewCell.m
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import "AssistiveTouchCollectionViewCell.h"
@interface AssistiveTouchCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AssistiveTouchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView{
    [self.contentView addSubview:self.titleLabel];
}
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.titleLabel.text = titleString;
    //self.titleLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)setIndex:(NSUInteger)index{
    _index = index;
}
- (void)tapAction{
    if(self.delegate && [self.delegate respondsToSelector:@selector(AssistiveTouchCollectionViewCell:index:)]){
        [self.delegate AssistiveTouchCollectionViewCell:self index:self.index];
    }
}
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.frame = CGRectMake(0, 0, 50, 40);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [_titleLabel setUserInteractionEnabled: YES];
//        AppDelegate *delegate = ((AppDelegate *)[UIApplication sharedApplication].delegate);
//        if(delegate.orientaionType == UIDeviceOrientationLandscapeLeft){
//            CGAffineTransform transformL =CGAffineTransformMakeRotation(M_PI_2);
//            [_titleLabel setTransform:transformL];
//        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [_titleLabel addGestureRecognizer:tap];
        
    }
    return _titleLabel;
}
@end
