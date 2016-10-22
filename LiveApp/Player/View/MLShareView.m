//
//  MLShareView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/22.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLShareView.h"

@interface MLShareView()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *weixinFriendBtn;
@property (nonatomic, strong) UIButton *weixinBtn;
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UIButton *qqkjBtn;
@property (nonatomic, strong) UITapGestureRecognizer *disappearViewGesture;

@property (nonatomic, strong) MLLiveCellModel *model;

@property (nonatomic, strong) UIView *topView;

@end

@implementation MLShareView

+ (void)showView:(MLLiveCellModel *)model{
    
    MLShareView *shareView = [[MLShareView alloc] initWithFrame:CGRectMake(0, MLScreenHeight, MLScreenWidth, MLScreenHeight)];
    
    shareView.model = model;
    
    [shareView showInWindow];
    
}

- (void)showInWindow{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
            [UIView animateWithDuration:MLHeaderViewanimateWithDuration animations:^{
                self.frame = CGRectMake(0, 0, MLScreenWidth, MLScreenHeight);
            } completion:^(BOOL finished) {
                [self addSubview:self.topView];
                [UIView animateWithDuration:0.6 animations:^{
                    self.topView.alpha =0.25f;
                    self.topView.frame = CGRectMake(0, 0, MLScreenWidth, MLScreenHeight*0.724);
                }];
            }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //毛玻璃
        UIBlurEffect *blureffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *visualeffectview = [[UIVisualEffectView alloc]initWithEffect:blureffect];//添加毛玻璃view视图
        visualeffectview.frame = CGRectMake(0, MLScreenHeight*0.724, MLScreenWidth,MLScreenHeight*0.276); //设置毛玻璃的frame
        [self addSubview:visualeffectview];
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, MLScreenWidth, MLScreenHeight)];
        self.topView.backgroundColor =[UIColor blackColor];
        self.topView.alpha = 0;
        [self addSubview:self.topView];
        
        UIImageView *shareImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, MLScreenHeight*0.724, MLScreenWidth,MLScreenHeight*0.276)];
        shareImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shareImage" ofType:@"png"]];
        [self addSubview:shareImageView];
        
        self.weixinFriendBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        self.weixinFriendBtn.frame =CGRectMake(MLScreenWidth*0.059f, MLScreenHeight*0.792, MLScreenHeight*0.068f, MLScreenHeight*0.068f);
        [self.weixinFriendBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wxpyq" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.weixinFriendBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.weixinFriendBtn];
        
        
        self.weixinBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        self.weixinBtn.frame =CGRectMake(MLScreenWidth*0.247f, MLScreenHeight*0.792, MLScreenHeight*0.068f, MLScreenHeight*0.068f);
        [self.weixinBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weixin" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [self.weixinBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.weixinBtn];
        
        
        self.weiboBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        self.weiboBtn.frame =CGRectMake(MLScreenWidth*0.433f, MLScreenHeight*0.792, MLScreenHeight*0.068f, MLScreenHeight*0.068f);
        [self.weiboBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weibo" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [self.weiboBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.weiboBtn];
        
        
        
        self.qqBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        self.qqBtn.frame =CGRectMake(MLScreenWidth*0.622f, MLScreenHeight*0.792, MLScreenHeight*0.068f, MLScreenHeight*0.068f);
        [self.qqBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qq" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [self.qqBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.qqBtn];
        
        self.qqkjBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        self.qqkjBtn.frame =CGRectMake(MLScreenWidth*0.817f, MLScreenHeight*0.792, MLScreenHeight*0.068f, MLScreenHeight*0.068f);
        [self.qqkjBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qqkj" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [self.qqkjBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.qqkjBtn];
        
        UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        backBtn.frame =CGRectMake(0, MLScreenHeight*0.932f, MLScreenWidth, MLScreenHeight*0.068f);
        [backBtn setTitle:@"取消" forState:UIControlStateNormal];
        backBtn.titleLabel.font =[UIFont systemFontOfSize:19];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:backBtn];
        
        //移除手势
        self.disappearViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnAction)];
        self.disappearViewGesture.delegate= self;//设置代理方法
        [self.topView addGestureRecognizer:self.disappearViewGesture];//事件者响应者
    }
    return self;
}

-(void)shareAction:(UIButton *)sender{
    if (sender ==self.weixinFriendBtn) {
        
    }else if(sender ==self.weixinBtn){
        
    }else if(sender ==self.weiboBtn){
        
    }else if(sender ==self.qqBtn){
        
    }else if(sender ==self.qqkjBtn){
        
    }
}
-(void)backBtnAction{
    
    [UIView animateWithDuration:MLHeaderViewanimateWithDuration animations:^{
        self.topView.alpha=0;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:MLHeaderViewanimateWithDuration animations:^{
            
            self.frame =CGRectMake(0, MLScreenHeight, MLScreenWidth, MLScreenHeight);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            [self.topView removeGestureRecognizer:self.disappearViewGesture];
        }];
        
        
    }];
}

@end
