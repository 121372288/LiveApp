//
//  MLPlayerViewController.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLPlayerViewController.h"
#import "MLLiveCellModel.h"

@interface MLPlayerViewController ()

@property (nonatomic, strong) MLPlayerScrollView *scrollView;

@property (nonatomic, strong) MLPlayerView *playView;

@end

@implementation MLPlayerViewController

-(MLPlayerScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[MLPlayerScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.playDelegate = self;
        self.scrollView.pagingEnabled = true;
        self.scrollView.bouncesZoom  = false;
        self.scrollView.bounces = false;
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator = false;
    }
    return _scrollView;
}

-(MLPlayerView *)playView{
    if (_playView == nil) {
        _playView = [[MLPlayerView alloc] initWithModel:self.liveArray[self.clickNumber]];
        _playView.delegate = self;
        
    }
    return _playView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.liveArray = self.liveArray;
    self.scrollView.clickNumber = self.clickNumber;
    self.scrollView.contenShowView = self.playView;
    
    [self.view addSubview:self.scrollView];
//    [self updateData];
    
}

- (void)updateData{
    
    // 创建模型赋值
    self.playView.model = self.liveArray[self.clickNumber];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@implementation  MLPlayerViewController(Extension)

#pragma mark - MLPlayerScrollViewDelegate
- (void)scrollViewScrollToPage:(NSInteger)page{
    self.clickNumber = page;
    [self updateData];
}

#pragma mark - MLPlayerViewDelegate
- (void)closePlayer{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
