//
//  MLLiveScrollView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MLLiveScrollViewTypeHot     = 0,
    MLLiveScrollViewTypeNew     = 1
}MLLiveScrollViewType;

@class MLHotView, MLNewView;

@interface MLLiveScrollView : UIScrollView

@property (nonatomic, strong) MLHotView *hotView;

@property (nonatomic, strong) MLNewView *nestView;

@end
