//
//  MLHeaderView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLHeaderView.h"

@interface MLHeaderView ()

@property (nonatomic, strong) UIButton *hotBtn;
@property (nonatomic, strong) UIButton *newsBtn;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation MLHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.hotBtn];
        [self addSubview:self.newsBtn];
        [self addSubview:self.lineView];
    }
    return self;
}

-(UIButton *)hotBtn{
    if (_hotBtn == nil) {
        _hotBtn = [self setButtonWithTitle:@"最热" frame:CGRectMake(0, 0, self.frame.size.width/2, 44) action:@selector(clickHotButton) titleColor:[UIColor whiteColor]];
    }
    return _hotBtn;
}

-(UIButton *)newsBtn{
    if (_newsBtn == nil) {
        _newsBtn = [self setButtonWithTitle:@"最新" frame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, 44) action:@selector(clickNewButton) titleColor:[UIColor grayColor]];
    }
    return _newsBtn;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        _lineView =[[UIView alloc]initWithFrame:CGRectMake(self.hotBtn.frame.size.width/2-20, 42, 40, 2)];
        _lineView.backgroundColor=[UIColor whiteColor];
    }
    return _lineView;
}

-(UIButton *)setButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(_Nonnull SEL)action titleColor:(UIColor *)titleColor{
    UIButton *commonBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    commonBtn.frame = frame;
    [commonBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [commonBtn setTitle:title forState:UIControlStateNormal];
    commonBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    [commonBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return commonBtn;
}

- (void)clickHotButton{
    
    [self changeSelectedButton:MLHeaderViewStateHot];
    if ([self.delegate respondsToSelector:@selector(headerViewhasClickHot)]) {
        [self.delegate headerViewhasClickHot];
    }
}

- (void)clickNewButton{
    
    [self changeSelectedButton:MLHeaderViewStateNew];
    if ([self.delegate respondsToSelector:@selector(headerViewhasClickNew)]) {
        [self.delegate headerViewhasClickNew];
    }
}

- (void)scrollViewIsScroll:(CGFloat)contentOffsetProportion{
    //contentOffsetProportion 比例  0 ~~  1
    CGFloat maxMoveCenterX = self.newsBtn.center.x - self.hotBtn.center.x;
    CGFloat lineCenterX = self.hotBtn.center.x + contentOffsetProportion * maxMoveCenterX;
    
    CGFloat lineCenterY = self.lineView.center.y;
    self.lineView.center = CGPointMake(lineCenterX, lineCenterY);
}

- (void)changeSelectedButton:(MLHeaderViewState)state{
    switch (state) {
        case MLHeaderViewStateHot:
        {
            [self.hotBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.newsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            break;
        }
        case MLHeaderViewStateNew:
        {
            [self.hotBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.newsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             break;
        }
        default:
            break;
    }
    
}



@end
