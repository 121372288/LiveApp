//
//  MLPlayerScrollView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLPlayerScrollView.h"
#import "MLLiveCellModel.h"
@interface MLPlayerScrollView ()

@property (nonatomic, strong) NSTimer *splashTimer;

@end

@implementation MLPlayerScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { self.backgroundColor = [UIColor redColor];
        [self addSubview:self.leftImageView];
        [self addSubview:self.centerImageView];
        [self addSubview:self.rightImageView];
        [self insertSubview:self.centerImageView atIndex:0];
        self.contentSize = CGSizeMake(MLScreenWidth * 3, MLScreenHeight);
        self.contentOffset = CGPointMake(MLScreenWidth, 0);
        [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)setLiveArray:(NSMutableArray *)liveArray{
    _liveArray = liveArray;
    if (liveArray.count == 1) {
        self.scrollEnabled = false;
    } else {
        self.scrollEnabled = true;
    }
    
}


-(void)setClickNumber:(NSInteger)clickNumber{
    _clickNumber = clickNumber;
    
    MLLiveCellModel *model = self.liveArray[self.clickNumber];
#if DEBUG
assert(self.liveArray.count > self.clickNumber);
#endif
    
    [self.centerImageView loadImageForURLString:model.bigpic ? model.bigpic : model.photo];
    MLLiveCellModel *leftModel;
    MLLiveCellModel *rightModel;
    if (self.clickNumber == 0) {
        leftModel = self.liveArray[self.liveArray.count - 1];
        rightModel = self.liveArray[self.clickNumber + 1];
    } else if (self.clickNumber == self.liveArray.count - 1) {
        leftModel = self.liveArray[self.clickNumber - 1];
        rightModel = self.liveArray[0];
    } else {
        leftModel = self.liveArray[self.clickNumber - 1];
        rightModel = self.liveArray[self.clickNumber + 1];
    }
    //图片赋值
    [self.leftImageView loadImageForURLString:leftModel.bigpic ? leftModel.bigpic : leftModel.photo];
    [self.rightImageView loadImageForURLString:rightModel.bigpic ? rightModel.bigpic : rightModel.photo];
}



-(UIImageView *)leftImageView{
    if (_leftImageView == nil) {
        _leftImageView = [self initializeImageWithFrame:CGRectMake(0, 0, MLScreenWidth, MLScreenHeight)];
    }
    return _leftImageView;
}

-(UIImageView *)centerImageView{
    if (_centerImageView == nil) {
        _centerImageView = [self initializeImageWithFrame:CGRectMake(MLScreenWidth, 0, MLScreenWidth, MLScreenHeight)];
    }
    return _centerImageView;
}

-(UIImageView *)rightImageView{
    if (_rightImageView == nil) {
        _rightImageView = [self initializeImageWithFrame:CGRectMake(MLScreenWidth * 2, 0, MLScreenWidth, MLScreenHeight)];
    }
    return _rightImageView;
}

- (UIImageView *)initializeImageWithFrame:(CGRect )frame {
    UIImageView *commonImage =[[UIImageView alloc]initWithFrame:frame];
    [commonImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    commonImage.contentMode = UIViewContentModeScaleAspectFill;
    commonImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    commonImage.clipsToBounds = true;
    return commonImage;
}

-(void)setContenShowView:(UIView *)contenShowView{
    [_contenShowView removeFromSuperview];
    
    _contenShowView = contenShowView;
    _contenShowView.frame = CGRectMake(MLScreenWidth, 0, MLScreenWidth, MLScreenHeight);
    [self insertSubview:_contenShowView atIndex:1];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqual: @"contentOffset"]) {
        
        [self adjustStateWithContentOffset];
        
    }
    
}

- (void)adjustStateWithContentOffset{
    
    if (self.contentOffset.x == 0) {
        self.centerImageView.image = self.leftImageView.image;
        self.contentOffset = CGPointMake(MLScreenWidth, 0);
        self.clickNumber = self.clickNumber==0 ? self.liveArray.count - 1 : self.clickNumber -1;
//        [self.contenShowView removeFromSuperview];
        if([self.playDelegate respondsToSelector:@selector(scrollViewScrollToPage:)]) {
            [self.playDelegate scrollViewScrollToPage:self.clickNumber];
        }
    } else if (self.contentOffset.x == MLScreenWidth *2) {
        self.centerImageView.image = self.rightImageView.image;
        self.contentOffset = CGPointMake(MLScreenWidth, 0);
//        [self.contenShowView removeFromSuperview];
        self.clickNumber = self.clickNumber==self.liveArray.count - 1 ? 0 : self.clickNumber + 1;
        if ([self.playDelegate respondsToSelector:@selector(scrollViewScrollToPage:)]) {
            [self.playDelegate scrollViewScrollToPage:self.clickNumber];
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentOffset"];
}

@end
