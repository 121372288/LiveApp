//
//  MLAllLiveController.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLHeaderView.h"
#import "MLLiveScrollView.h"

@interface MLAllLiveController : UIViewController

+ (instancetype) shareManager;

/* 控制展示和隐藏头部底部item */
- (void)hiddenNCAndTC;
- (void)appearNCAndTC;

/* 控制变化视图-ptrsent */
- (void)presentToNextViewControllerWithIdentifying:(MLLiveScrollViewType)Identifying VCInfoArray:(NSMutableArray *)VCInfoArray clickNumber:(NSInteger)number;

@end

@interface MLAllLiveController(Extension)<MLHeaderViewDelegate, UIScrollViewDelegate>

@end
