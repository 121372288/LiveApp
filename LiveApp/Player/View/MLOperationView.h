//
//  MLOperationView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/20.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLOperationViewDelegate <NSObject>

@optional
- (void)closeAction;

@end

@interface MLOperationView : UIView

@property (nonatomic, weak) id<MLOperationViewDelegate> delegate;

@property (nonatomic, strong) MLLiveCellModel *model;

- (void)operationDisappear;
- (void)operationAppear;

@end
