//
//  MLAllLiveController.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLAllLiveController.h"
#import "MLHotView.h"
#import "MLNewView.h"
@interface MLAllLiveController ()

@property (nonatomic, strong) MLHeaderView *headerView;

@property (nonatomic, strong) MLLiveScrollView *scrollView;

@end

@implementation MLAllLiveController

+ (instancetype) shareManager{
    static MLAllLiveController *handle =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle =[[MLAllLiveController alloc]init];
    });
    return handle;
}

-(MLLiveScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView =[[MLLiveScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _scrollView.backgroundColor =[UIColor blackColor];
        _scrollView.contentSize =CGSizeMake(kWidth * 2, kHeight-113);
        _scrollView.contentOffset =CGPointMake(0, 0);
        _scrollView.pagingEnabled =YES;
        _scrollView.bouncesZoom  =NO;
        _scrollView.bounces =NO;
        _scrollView.delegate =self;
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    [self.view addSubview:self.scrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loginStatus];//登录状态
    });
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)setupNavigation{
    self.navigationController.navigationBar.translucent = true;
    UIColor * color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, MLScreenWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor =[UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    MLHeaderView *headView =[[MLHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth*0.724f, 44)];
    headView.delegate = self;
    self.navigationItem.titleView = headView;
    
}

- (void)appearNCAndTC{

    [UIView animateWithDuration:HeaderViewanimateWithDuration animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, 20,MLScreenWidth, 44);
        self.tabBarController.tabBar.frame =CGRectMake(0, MLScreenHeight-49, MLScreenWidth, 49);
        self.scrollView.hotView.frame = CGRectMake(0, 64, MLScreenWidth, MLScreenHeight - 113);
    }];
}

- (void)hiddenNCAndTC{

    [UIView animateWithDuration:HeaderViewanimateWithDuration animations:^{
        self.navigationController.navigationBar.frame =CGRectMake(0, -44,MLScreenWidth, 44);
        self.tabBarController.tabBar.frame = CGRectMake(0, MLScreenHeight, MLScreenWidth, 49);
        self.scrollView.hotView.frame = CGRectMake(0, 0, MLScreenWidth, MLScreenHeight);
    }];
}

- (void)presentToNextViewControllerWithIdentifying:(MLLiveScrollViewType)Identifying VCInfoArray:(NSMutableArray *)VCInfoArray clickNumber:(NSInteger)number{
    
    MLPlayerViewController *player = [[MLPlayerViewController alloc] init];
    player.type = Identifying;
    player.liveArray = VCInfoArray;
    player.clickNumber = number;
    [self presentViewController:player animated:true completion:nil];
}

- (void)loginStatus{
    if(![MLLoginTools loginStatus]){
        [self presentViewController:[[MLLoginAndRedisterController alloc] init] animated:true completion:nil];
    }
}

@end

@implementation MLAllLiveController(Extension)

-(void)headerViewhasClickHot{
    [self.scrollView setContentOffset:CGPointZero animated:true];
}

- (void)headerViewhasClickNew{
    [self.scrollView setContentOffset:CGPointMake(MLScreenWidth, 0) animated:true];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = scrollView.contentSize.width/2;
    // 计算滑动的比例
    CGFloat point = 1 - (width - scrollView.contentOffset.x)/width;
    [((MLHeaderView *)self.navigationItem.titleView) scrollViewIsScroll:point];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [((MLHeaderView *)self.navigationItem.titleView) changeSelectedButton:MLHeaderViewStateHot];
    } else {
        [((MLHeaderView *)self.navigationItem.titleView) changeSelectedButton:MLHeaderViewStateNew];
    }
}


@end
