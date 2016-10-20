//
//  MLPlayerScrollView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLLiveCellModel;

@protocol MLPlayerScrollViewDelegate <NSObject, UIScrollViewDelegate>

@optional

- (void)scrollViewScrollToPage:(NSInteger)page;
//- (void)scrollViewScrollToRight;

@end

@interface MLPlayerScrollView : UIScrollView

@property (nonatomic, strong, ) UIImageView *leftImageView;
@property (nonatomic, strong, ) UIImageView *centerImageView;
@property (nonatomic, strong, ) UIImageView *rightImageView;

@property (nonatomic, weak) id <MLPlayerScrollViewDelegate> playDelegate;

@property (nonatomic, strong) NSMutableArray<MLLiveCellModel *> *liveArray;
@property (nonatomic, assign) NSInteger clickNumber;

@property (nonatomic, strong) UIView *contenShowView;

@end
