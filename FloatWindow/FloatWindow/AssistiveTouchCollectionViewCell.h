//
//  AssistiveTouchCollectionViewCell.h
//  windowTouch
//
//  Created by zhangk on 2017/8/10.
//  Copyright © 2017年 张坤. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AssistiveTouchCollectionViewCell;

@protocol AssistiveTouchCollectionViewCellDelegate <NSObject>

- (void)AssistiveTouchCollectionViewCell:(AssistiveTouchCollectionViewCell *)cell index:(NSUInteger)index;

@end
@interface AssistiveTouchCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, weak) id<AssistiveTouchCollectionViewCellDelegate> delegate;
@end
