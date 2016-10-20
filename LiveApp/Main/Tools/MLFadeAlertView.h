//
//  MLFadeAlertView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自动消失的弹窗
 */
@interface MLFadeAlertView : UIView

/**
 *  弹窗显示的文字
 */
@property (copy) NSString *showText;

/**
 *  弹窗字体大小
 */
@property(retain) UIFont *textFont;

/**
 *  整个FadeView的宽度
 */
@property(assign) CGFloat fadeWidth;

/**
 *  整个FadeView的背景色
 */
@property(retain) UIColor *fadeBGColor;

/**
 *  提示语颜色
 */
@property(retain) UIColor *titleColor;

/**
 *  宽度边框
 */
@property(assign) CGFloat textOffWidth;

/**
 *  高度边框
 */
@property(assign) CGFloat textOffHeight;

/**
 *  距离屏幕下方高度
 */
@property(assign) CGFloat textBottomHeight;

/**
 *  自动消失时间
 */
@property (assign) CGFloat fadeTime;

/**
 *  背景的透明度
 */
@property(assign) CGFloat FadeBGAlpha;





/**
 *  显示弹窗
 *
 *  str 弹窗文字
 *
 */
- (void)showAlertWith:(NSString *)str;


@end
