//
//  MLHotView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLHotView : UIView

@property (nonatomic, strong) UITableView *tableView;

@end

@interface MLHotView(Externsion)<UITableViewDelegate, UITableViewDataSource>

@end


