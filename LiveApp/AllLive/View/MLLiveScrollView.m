//
//  MLLiveScrollView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLLiveScrollView.h"
#import "MLHotView.h"
#import "MLNewView.h"
@implementation MLLiveScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotView];
        [self addSubview:self.nestView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.hotView.frame = CGRectMake(0, 64, MLScreenWidth, self.frame.size.height);
    self.nestView.frame = CGRectMake(MLScreenWidth, 64, MLScreenWidth, self.frame.size.height);
}

-(MLHotView *)hotView{
    if (_hotView == nil) {
        _hotView =[[MLHotView alloc] initWithFrame:CGRectMake(0, 64, MLScreenWidth, self.frame.size.height)];
    }
    return _hotView;
}

-(MLNewView *)nestView{
    if (_nestView == nil) {
        _nestView =[[MLNewView alloc] initWithFrame:CGRectMake(MLScreenWidth, 64, MLScreenWidth, self.frame.size.height)];
    }
    return _nestView;
}

@end
