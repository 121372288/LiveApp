//
//  CALayer+MLLoadingLayer.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/22.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "CALayer+MLLoadingLayer.h"

@implementation CALayer (MLLoadingLayer)

+ (void)loadingLayerToView:(UIView *)view{
    
    int numofInstance = 10;
    //动画时长
    CGFloat duration = 1.0f;
    //创建repelicator对象
    CAReplicatorLayer *repelicator = [CAReplicatorLayer layer];
    //设置其位置
    repelicator.frame = view.bounds;
    //需要生成多少个相同实例
    repelicator.instanceCount = numofInstance;
    //代表实例生成的延时时间;
    repelicator.instanceDelay = duration / numofInstance;
    //设置每个实例的变换样式
    repelicator.instanceTransform = CATransform3DMakeRotation(M_PI * 2.0 / 10.0, 0, 0, 1);
    
    //创建repelicator对象的子图层，repelicator会利用此子图层进行高效复制。并绘制到自身图层上
    CALayer *layer = [CALayer layer];
    //设置子图层的大小位置
    layer.frame = CGRectMake(0, 0, 10, 10);
    //子图层的仿射变换是基于repelicator图层的锚点，因此这里将子图层的位置摆放到此锚点附近。
    //    CGPoint point = [repelicator convertPoint:repelicator.position fromLayer:_loadingView.layer];
    
    layer.position = CGPointMake(view.frame.size.width/4, view.frame.size.height/2);
    //设置子图层的背景色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    //将子图层切圆
    layer.cornerRadius = 5;
    //将子图层添加到repelicator上
    [repelicator addSublayer:layer];
    //对layer进行动画设置
    CABasicAnimation *animaiton = [CABasicAnimation animation];
    //设置动画所关联的路径属性
    animaiton.keyPath = @"transform.scale";
    //设置动画起始和终结的动画值
    animaiton.fromValue = @(1);
    animaiton.toValue = @(0.1);
    //设置动画时间
    animaiton.duration = duration;
    //设置动画次数
    animaiton.repeatCount = INT_MAX;
    //完成时是否取消动画操作带来的变化
    animaiton.removedOnCompletion = false;
    //添加动画
    [layer addAnimation:animaiton forKey:nil];
    [view.layer addSublayer:repelicator];
}

@end
