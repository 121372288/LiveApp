//
//  MLInputChatView.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/22.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLInputChatDelegate <NSObject>

@optional
-(void)frameValue:(int)value;

-(void)inputChatViewCententUserName:(NSString*)userName  ChatCentent:(NSString *)chatCentent cententType:(NSInteger)type;

@end


@interface MLInputChatView : UIView

@property(nonatomic,strong)UITextField *textField;

@property (nonatomic, assign) id<MLInputChatDelegate> delegate;

+(instancetype)sharedManage;

- (void)showInView:(UIView *)superView;
@end
