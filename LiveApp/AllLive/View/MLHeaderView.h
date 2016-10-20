//
//  MLHeaderView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MLHeaderViewStateHot      = 0,
    MLHeaderViewStateNew      = 1
}MLHeaderViewState;

@protocol MLHeaderViewDelegate <NSObject>

@optional
- (void)headerViewhasClickHot;
- (void)headerViewhasClickNew;

@end

@interface MLHeaderView : UIView

@property (nonatomic, weak) id <MLHeaderViewDelegate> delegate;

- (void)scrollViewIsScroll:(CGFloat)contentOffsetX;
    
- (void)changeSelectedButton:(MLHeaderViewState)state;

@end
