//
//  MLLiveTableViewCell.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLLiveCellModel;

@interface MLLiveTableViewCell : UITableViewCell

@property (nonatomic, strong) MLLiveCellModel *model;

//-(void)setUpTheCellModel:(MLLiveCellModel *)model;

@end
