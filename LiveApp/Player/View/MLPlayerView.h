//
//  MLPlayerView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/19.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLLiveCellModel;

@protocol MLPlayerViewDelegate <NSObject>

@optional
- (void)closePlayer;

@end

@interface MLPlayerView : UIView

@property (nonatomic, strong) MLLiveCellModel *model;

@property (nonatomic, weak) id<MLPlayerViewDelegate> delegate;

- (void)preparePlayer;

- (instancetype)initWithModel:(MLLiveCellModel *)model;

@end
