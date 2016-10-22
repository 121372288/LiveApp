//
//  MLOperationView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/20.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLOperationView.h"
#import "MLHeartFlyView.h"
#import "CALayer+MLLoadingLayer.h"
#import "MLShareView.h"
#import "MLInputChatView.h"
#import "MLInformationHeadView.h"
#import "MLLiveCellModel.h"
@interface MLOperationView ()<MLInputChatDelegate>
/* 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) MLInformationHeadView *informationHeadView;
/* 聊天按钮 */
@property(nonatomic,strong)UIButton * chatBtn;
/* 礼物按钮 */
@property(nonatomic,strong)UIButton * giftBtn;
/* 分享按钮 */
@property(nonatomic,strong)UIButton * shareBtn;
/* 加载loading图片 */
@property (nonatomic, strong) UIView *loadingView;

@property (nonatomic, assign) BOOL showView;

@property(nonatomic,strong)NSTimer *splashTimer;

@end

@implementation MLOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backButton];
        [self addSubview:self.loadingView];
        [self addSubview:self.chatBtn];
        [self addSubview:self.giftBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.informationHeadView];
        self.splashTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(rote) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setModel:(MLLiveCellModel *)model{
    _model = model;
    self.informationHeadView.liveID = model.useridx;
}

-(MLInformationHeadView *)informationHeadView{
    if (_informationHeadView == nil) {
        _informationHeadView = [[[NSBundle mainBundle] loadNibNamed:@"MLInformationHeadView" owner:nil options:nil] firstObject];
        _informationHeadView.frame = CGRectMake(0, 0, MLScreenWidth, 125);
    }
    return _informationHeadView;
}

-(UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(MLScreenWidth-43, MLScreenHeight- 43, 33, 33);
        [_backButton setImage:[UIImage imageNamed:@"talk_close_40x40"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _backButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _backButton.layer.shadowOffset = CGSizeMake(0, 0);
        _backButton.layer.shadowOpacity = 0.5;
        _backButton.layer.shadowRadius = 1;
    }
    return _backButton;
}

-(UIView *)loadingView{
    if (_loadingView == nil) {
        CGFloat imageWH = 67;
        CGFloat viewX = (MLScreenWidth - imageWH) * 0.5;
        CGFloat viewY = (MLScreenHeight - imageWH) * 0.5;
        _loadingView = [[UIView alloc]initWithFrame:CGRectMake(viewX, viewY, imageWH, imageWH)];
        [CALayer loadingLayerToView:_loadingView];
    }
    return _loadingView;
}


-(UIButton *)chatBtn{
    if (_chatBtn == nil) {
        UIButton *chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chatBtn.frame = CGRectMake(10, MLScreenHeight- 43, 33, 33);
        [chatBtn setImage:[UIImage imageNamed:@"talk_private_40x40"] forState:UIControlStateNormal];
        [chatBtn addTarget:self action:@selector(chatBtnAction) forControlEvents:UIControlEventTouchUpInside];
        chatBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        chatBtn.layer.shadowOffset = CGSizeMake(0, 0);
        chatBtn.layer.shadowOpacity = 0.5;
        chatBtn.layer.shadowRadius = 1;
        _chatBtn = chatBtn;
    }
    return _chatBtn;
}

-(UIButton *)giftBtn{
    if (_giftBtn == nil) {
        UIButton *giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        giftBtn.frame = CGRectMake(MLScreenWidth * 0.5-16, MLScreenHeight- 43, 33, 33);
        [giftBtn setImage:[UIImage imageNamed:@"talk_sendgift_40x40"] forState:UIControlStateNormal];
        [giftBtn addTarget:self action:@selector(giftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        giftBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        giftBtn.layer.shadowOffset = CGSizeMake(0, 0);
        giftBtn.layer.shadowOpacity = 0.5;
        giftBtn.layer.shadowRadius = 1;
        _giftBtn = giftBtn;
    }
    return _giftBtn;
}

-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(MLScreenWidth-86, MLScreenHeight- 43, 33, 33);
        [shareBtn setImage:[UIImage imageNamed:@"talk_share_40x40"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
        shareBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        shareBtn.layer.shadowOffset = CGSizeMake(0, 0);
        shareBtn.layer.shadowOpacity = 0.5;
        shareBtn.layer.shadowRadius = 1;
        _shareBtn = shareBtn;
    }
    return _shareBtn;
}

#pragma mark -buttonAction
- (void)backButtonAction{
    
    if ([self.delegate respondsToSelector:@selector(closeAction)]) {
        [self.delegate closeAction];
    }
    
}

- (void)chatBtnAction{
    MLInputChatView *inputView = [MLInputChatView sharedManage];
    inputView.delegate = self;
    [inputView showInView:self];
}

- (void)giftBtnAction{
    
}

- (void)shareBtnAction{
    
    [MLShareView showView:self.model];
    
}
/* 控制视图模式  是否在加载 */
- (void)operationDisappear{
    self.loadingView.layer.hidden = false;

    self.chatBtn.hidden = true;
    self.giftBtn.hidden = true;
    self.shareBtn.hidden = true;
    self.informationHeadView.hidden = true;
}
- (void)operationAppear{
    self.loadingView.layer.hidden = true;
    
    self.chatBtn.hidden = false;
    self.giftBtn.hidden = false;
    self.shareBtn.hidden = false;
    self.informationHeadView.hidden = false;
}
/* 爱心定时器刷爱心 */
- (void)rote{
    MLHeartFlyView* heart = [[MLHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self addSubview:heart];
    heart.frame =CGRectMake(MLScreenWidth-60, MLScreenHeight-100, 50, 50);
    [heart animateInView:self];
}

-(void)dealloc{
    [self.splashTimer invalidate];
}

@end

@implementation MLOperationView (Extension)

- (void)inputChatViewCententUserName:(NSString *)userName ChatCentent:(NSString *)chatCentent cententType:(NSInteger)type{
    
}



@end
