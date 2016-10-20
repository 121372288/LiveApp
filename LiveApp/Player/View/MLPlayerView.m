//
//  MLPlayerView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/19.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLPlayerView.h"
#import "MLLiveCellModel.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "MLOperationView.h"
@interface MLPlayerView ()<MLOperationViewDelegate>

@property (nonatomic, retain) id<IJKMediaPlayback> player;

@property (nonatomic, strong) UIView *playView;

@property (nonatomic, strong) MLOperationView *operationView;

@end

@implementation MLPlayerView

- (instancetype)initWithModel:(MLLiveCellModel *)model
{
    self = [super init];
    if (self) {
        self.model = model;
        [self addSubview:self.operationView];
    }
    return self;
}

-(MLOperationView *)operationView{
    if (_operationView == nil) {
        _operationView = [[MLOperationView alloc] initWithFrame:CGRectMake(0, 0, MLScreenWidth, MLScreenHeight)];
        _operationView.delegate = self;
    }
    return _operationView;
}

- (void)preparePlayer{
    if (![self.player isPlaying]) {
        // 准备播放
        [self.player prepareToPlay];
    }
}

-(void)setModel:(MLLiveCellModel *)model{
    _model = model;
    self.operationView.model = model;
    [self preparePlayingData];
}

- (void)preparePlayingData {
    
    [self.player shutdown];
    [self.playView removeFromSuperview];
    
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:self.model.flv] withOptions:nil];
    UIView *playerview = [self.player view];
    self.playView = [self.player view];
    playerview.frame = CGRectMake(0, 0, MLScreenWidth, MLScreenHeight);
    playerview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    [self insertSubview:self.playView atIndex:0];
    // 操作视图隐藏
    [self.operationView operationDisappear];
    // 准备播放
    [self preparePlayer];
    // 注册观察者
    [self installMovieNotificationObservers];
}

#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
    //    self.splashTimer = nil;
    //
    //    self.splashTimer = [NSTimer scheduledTimerWithTimeInterval:1  target:self selector:@selector(rote) userInfo:nil repeats:YES];
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}


#pragma mark Notification callBack

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
//        _dimIamge.hidden = YES;
    
        switch (_player.playbackState) {
    
            case IJKMPMoviePlaybackStateStopped:
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
                break;
    
            case IJKMPMoviePlaybackStatePlaying:{
                //播放
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
                // 开始播放后添加操作
                [self.operationView operationAppear];
//                [self.scrollView addSubview:self.liveInformationView];
    // 加入聊天室
            }
                break;
    
            case IJKMPMoviePlaybackStatePaused:
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
                break;
    
            case IJKMPMoviePlaybackStateInterrupted:
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
                break;
    
            case IJKMPMoviePlaybackStateSeekingForward:
            case IJKMPMoviePlaybackStateSeekingBackward: {
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
                break;
            }
    
            default: {
                NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
                break;
            }
        }
}

- (void)rote{
    //    _heartSize = 35;
    //
    //    DMHeartFlyView* heart = [[DMHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    //    [self.scrollView addSubview:heart];
    //    //    CGPoint fountainSource = CGPointMake(SCREENWIDTH-_heartSize, self.view.bounds.size.height - _heartSize/2.0 - 10);
    //    //    heart.center = fountainSource;
    //    
    //    heart.frame =CGRectMake(SCREENWIDTH*2-60, SCREENHEIGHT-100, 50, 50);
    //    [heart animateInView:self.view];
}

- (void)dealloc {
    [self removeMovieNotificationObservers];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - operationViewDelegate
- (void)closeAction{
    [self.player shutdown];
    if ([self.delegate respondsToSelector:@selector(closePlayer)]) {
        [self.delegate closePlayer];
    }
}

@end
