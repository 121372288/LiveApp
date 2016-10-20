//
//  MLPlayerViewController.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLLiveScrollView.h"
#import "MLPlayerScrollView.h"
#import "MLPlayerView.h"
@interface MLPlayerViewController : UIViewController

@property (nonatomic, assign) NSInteger clickNumber;

@property (nonatomic, assign) MLLiveScrollViewType type;

@property (nonatomic, strong) NSMutableArray<MLLiveCellModel *> *liveArray;

@end

@interface MLPlayerViewController(Extension)<MLPlayerScrollViewDelegate, MLPlayerViewDelegate>


@end
