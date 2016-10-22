//
//  MLInputChatView.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/22.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLInputChatView.h"

@interface MLInputChatView ()<UIGestureRecognizerDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *disappearViewGesture;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *swithBtn;
@property (nonatomic, strong) UIImageView *swithImageView;

@property (nonatomic, assign) BOOL BarrageState;

@end

@implementation MLInputChatView

+(instancetype)sharedManage{
    static MLInputChatView *header =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        header =[[MLInputChatView alloc]initWithFrame:CGRectMake(0, MLScreenHeight, MLScreenWidth, MLScreenHeight)];
    });
    return header;
}

- (void)showInView:(UIView *)superView{
    [superView addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, 0, MLScreenWidth, MLScreenHeight);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, MLScreenWidth, MLScreenHeight*0.932f)];
        [self addSubview:self.topView];
        
        //移除手势
        self.disappearViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disappearShareViewAction)];
        self.disappearViewGesture.delegate= self;//设置代理方法
        [self.topView addGestureRecognizer:self.disappearViewGesture];//事件者响应者
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, MLScreenHeight*0.932f, MLScreenWidth, MLScreenHeight*0.068f)];
        imageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"theInput" ofType:@"png"]];
        [self addSubview:imageView];
        
        self.textField =[[UITextField alloc]initWithFrame:CGRectMake(MLScreenWidth*0.153f, MLScreenHeight*0.943f, MLScreenWidth*0.731f, MLScreenHeight*0.043)];
        self.textField.delegate =self;
        self.textField.font = [UIFont fontWithName:@"Arial" size:14.0f];
        self.textField.placeholder =@"说点什么吧";
        [self addSubview:self.textField];
        
        
        self.swithImageView =[[UIImageView alloc]initWithFrame:CGRectMake(5, MLScreenHeight*0.943f, MLScreenWidth*0.12f, MLScreenHeight*0.043)];
        self.swithImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"swithBackgroud" ofType:@"png"]];
        [self addSubview:self.swithImageView];
        
        self.swithBtn =[[UIButton alloc]initWithFrame:CGRectMake(7, MLScreenHeight*0.943f+2,self.swithImageView.frame.size.width *0.7f-4, MLScreenHeight*0.043-4)];
        [self.swithBtn setImage:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"swith" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.swithBtn addTarget:self action:@selector(swithBtn:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.swithBtn];
        
        UIButton *sendBtn =[UIButton buttonWithType:UIButtonTypeSystem];
        sendBtn.frame =CGRectMake(MLScreenWidth*0.884f+5, MLScreenHeight*0.943f, MLScreenWidth*0.116f-10, MLScreenHeight*0.043);
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchDown];
        [self addSubview:sendBtn];
        
        //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
        self.BarrageState =0;
    }
    return self;
}

-(void)disappearShareViewAction{
    [self.textField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame =CGRectMake(0, MLScreenHeight, MLScreenWidth, MLScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        //        [self.topView removeGestureRecognizer:self.disappearViewGesture];
    }];
    
    
}

-(void)swithBtn:(UIButton *)sender{
    if (self.BarrageState ==0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.swithImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"swithBackgroudGreen" ofType:@"png"]];
            self.swithBtn.frame =CGRectMake(7+self.swithImageView.frame.size.width *0.3f, MLScreenHeight*0.943f+2,self.swithImageView.frame.size.width *0.7f-4, MLScreenHeight*0.043-4);
            self.textField.placeholder =@"发送弹幕,1币/条";
            self.BarrageState =1;
        }];
        
    }else{
        [UIView animateWithDuration:0.1 animations:^{
            self.swithImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"swithBackgroud" ofType:@"png"]];
            self.swithBtn.frame =CGRectMake(7, MLScreenHeight*0.943f+2,self.swithImageView.frame.size.width *0.7f-4, MLScreenHeight*0.043-4);
            
        }];
        self.textField.placeholder =@"说点什么吧";
        self.BarrageState =0;
    }
}

//点return收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self sendBtnAction];
    return YES;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, -height,MLScreenWidth,MLScreenHeight);
    }];
    
    //做一个判断, 当有了代理人且代理人有协议方法时才进行传值, 以免崩溃
    if (self.delegate && [self.delegate respondsToSelector:@selector(frameValue:)]) {
        //将自己的 textField.text 传给代理人
        [self.delegate frameValue:height];
    }
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = CGRectMake(0, 0, MLScreenWidth,MLScreenHeight);
    }];
    //做一个判断, 当有了代理人且代理人有协议方法时才进行传值, 以免崩溃
    if (self.delegate && [self.delegate respondsToSelector:@selector(frameValue:)]) {
        //将自己的 textField.text 传给代理人
        [self.delegate frameValue:0];
    }
}
-(void)sendBtnAction{
    
    if (![self isEmpty:self.textField.text]) {
        //做一个判断, 当有了代理人且代理人有协议方法时才进行传值, 以免崩溃
        if (self.delegate && [self.delegate respondsToSelector:@selector(inputChatViewCententUserName:ChatCentent:cententType:)]) {
            //将自己的值传给代理人
            [self.textField resignFirstResponder];
            self.textField.text =@"";
        }
    }else{
    }
}

-(BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


@end
