//
//  MLLoginAndRedisterController.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLLoginAndRedisterController.h"
//#import<CommonCrypto/CommonDigest.h>//sha1验证
#import "MLProfileController.h"
@interface MLLoginAndRedisterController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backgroundPicture;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UIButton *downBtn;//下面登录或注册按钮
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *token;

@end

@implementation MLLoginAndRedisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.backgroundPicture =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.4f)];
    self.backgroundPicture.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loginAndRegistered" ofType:@"jpg"]];
    [self.view addSubview:self.backgroundPicture];
    
    
    UIImageView *backgroundDownImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*0.4f, self.view.frame.size.width, self.view.frame.size.height*0.6f)];
    backgroundDownImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"backgroundDownImage" ofType:@"png"]];
    [self.view addSubview:backgroundDownImageView];
    
    UIImageView *logoImageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.backgroundPicture.frame.size.width/2-self.view.frame.size.width*0.066f, self.backgroundPicture.frame.size.height/2.5-self.view.frame.size.width*0.066f, self.view.frame.size.width*0.132f, self.view.frame.size.width*0.132f)];
    logoImageView.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"]];
    [self.view addSubview:logoImageView];
    
    UILabel *logoTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, self.backgroundPicture.frame.size.height/2, self.view.frame.size.width, 40)];
    logoTitle.font=[UIFont systemFontOfSize:20];
    logoTitle.textColor =[UIColor whiteColor];
    logoTitle.textAlignment=NSTextAlignmentCenter;
    logoTitle.text=@"咪咪直播";
    [self.view addSubview:logoTitle];
    
    UIButton *backBtn =[[UIButton alloc]initWithFrame:CGRectMake(10, 30, 35, 21)];
    backBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [backBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchDown];
    //    [self.view addSubview:backBtn];
    
    UIButton *registeredBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    registeredBtn.frame = CGRectMake(0, self.view.frame.size.height*0.344f, self.view.frame.size.width/2, 30);
    registeredBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    [registeredBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registeredBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registeredBtn addTarget:self action:@selector(registeredBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registeredBtn];
    
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height*0.344f, self.view.frame.size.width/2, 30);
    loginBtn.titleLabel.font =[UIFont systemFontOfSize:18];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBtn];
    
    
    UIImageView *triangleImageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4-12,self.backgroundPicture.frame.size.height-24, 24, 24)];
    triangleImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"triangleImage" ofType:@"png"]];
    triangleImageView.tag =100;
    [self.view addSubview:triangleImageView];
    
    self.accountTextField =[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.12f, self.view.frame.size.height*0.439f, self.view.frame.size.width*0.76f, 35)];
    self.accountTextField.placeholder=@"用户名 (5~20个字符,由字母和数字组成)";
    self.accountTextField.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:self.accountTextField];
    self.accountTextField.delegate=self;
    
    self.passwordTextField =[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*0.12f, self.view.frame.size.height*0.512f, self.view.frame.size.width*0.76f, 35)];
    self.passwordTextField.placeholder=@"密码 (6~20位)";
    self.passwordTextField.secureTextEntry =YES;
    self.passwordTextField.font =[UIFont systemFontOfSize:14];
    [self.view addSubview:self.passwordTextField];
    self.passwordTextField.delegate =self;
    
    self.downBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    self.downBtn.frame = CGRectMake(0, kHeight*0.583f, kWidth, kHeight*0.052f);
    [self.downBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.downBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(downBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.downBtn];
    self.downBtn.tag = 1;//默认为注册
    
    UIButton *leftLoginAgreement =[UIButton buttonWithType:UIButtonTypeSystem];
    leftLoginAgreement.frame= CGRectMake(0, kHeight*0.856f, kWidth*0.61f, 25);
    [leftLoginAgreement setTitle:@"登录或者注册即同意咪咪直播" forState:UIControlStateNormal];
    [leftLoginAgreement setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftLoginAgreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    leftLoginAgreement.titleLabel.font =[UIFont systemFontOfSize:13];
    [leftLoginAgreement addTarget:self action:@selector(LoginAgreementAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:leftLoginAgreement];
    
    UIButton *rightLoginAgreement =[UIButton buttonWithType:UIButtonTypeSystem];
    rightLoginAgreement.frame = CGRectMake(kWidth*0.61f, kHeight*0.856f, kWidth*0.39f, 25);
    [rightLoginAgreement setTitle:@"用户服务协议" forState:UIControlStateNormal];
    [rightLoginAgreement setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightLoginAgreement.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightLoginAgreement.titleLabel.font =[UIFont systemFontOfSize:13];
    [rightLoginAgreement addTarget:self action:@selector(LoginAgreementAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:rightLoginAgreement];
    
    
    
    UIImageView *thirdPartyLoginImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, kHeight*0.92f, kWidth, kHeight*0.08f)];
    thirdPartyLoginImageView.image =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"thirdPartyLoginImage" ofType:@"png"]];
    //    [self.view addSubview:thirdPartyLoginImageView];
    
    
    
    
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

}

//关闭按钮
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//上方点击登录事件
-(void)loginBtnAction{
    self.downBtn.tag = 2;
    self.accountTextField.placeholder=@"用户名";
    self.passwordTextField.placeholder=@"密码";
    [self.downBtn setTitle:@"登录" forState:UIControlStateNormal];
    UIView *triangleImageView = [self.view viewWithTag:100];
    [UIView animateWithDuration:0.25 animations:^{
        triangleImageView.frame =CGRectMake(self.view.frame.size.width*0.75f-12, self.backgroundPicture.frame.size.height-24, 24, 24);
        
    }];
    
    
    
}
//上方点击注册事件
-(void)registeredBtnAction{
    self.downBtn.tag = 1;
    self.accountTextField.placeholder=@"用户名 (5~20个字符,由字母和数字组成)";
    self.passwordTextField.placeholder=@"密码 (5~20位)";
    [self.downBtn setTitle:@"注册" forState:UIControlStateNormal];
    UIView *triangleImageView = [self.view viewWithTag:100];
    [UIView animateWithDuration:0.25 animations:^{
        triangleImageView.frame =CGRectMake(self.view.frame.size.width/4-12, self.backgroundPicture.frame.size.height-24, 24, 24);
        
    }];
    
    
}
//下方按钮点击事件
-(void)downBtnAction{
    if (![self isEmpty:self.accountTextField.text] && ![self isEmpty:self.passwordTextField.text]) {
        
        
        
        if (self.accountTextField.text.length>=5 && self.passwordTextField.text.length>=5) {
            
            
            if (self.downBtn.tag ==1) {
                //注册
                BmobUser *bUser = [[BmobUser alloc] init];
                [bUser setUsername:self.accountTextField.text];
                [bUser setPassword:self.passwordTextField.text];
                [bUser setObject:self.accountTextField.text forKey:@"nickName"];
                [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
                    MLFadeAlertView *fadelertView = [[MLFadeAlertView alloc]init];
                    if (isSuccessful){
                        [self textFieldShouldReturn:self.accountTextField];
                        [fadelertView showAlertWith:@"\n  注册成功  \n"];
                        [self  loginBtnAction];
                        
                    } else {
                        NSString *str =[NSString stringWithFormat:@"%@",error];
                        //                NSLog(@"%@",str);
                        if ([str containsString:@"already taken"]) {
                            [fadelertView showAlertWith:@"注册失败\n账户名已存在"];
                        }else  if ([str containsString:@"connect failed"]){
                            [fadelertView showAlertWith:@"注册失败\n请检查网络"];
                        }else{
                            [fadelertView showAlertWith:@"\n  注册失败  \n"];
                        }
                        
                        [self textFieldShouldReturn:self.accountTextField];
                        
                    }
                }];
                
                
                
                
            }else{
                //登录
                [BmobUser loginWithUsernameInBackground:self.accountTextField.text  password:self.passwordTextField.text];
                
                MLFadeAlertView *fadelertView = [[MLFadeAlertView alloc]init];
                [BmobUser loginInbackgroundWithAccount:self.accountTextField.text andPassword:self.passwordTextField.text block:^(BmobUser *user, NSError *error) {
                    if (user) {
                        MLUserModel *model = [MLUserModel defaultModel];
                        
                        model.userName =user.username;
                        model.nickName =[user objectForKey:@"nickName"];
//                        MLProfileController *profieVC = [MLProfileController shareManager];
                        
                        BmobFile *file = (BmobFile*)[user objectForKey:@"headPortrait"];
                        if (file.url) {
                            model.headPortrait = file.url;
                        } else {
                            model.headPortrait = @"";
                        }

                        [self textFieldShouldReturn:self.accountTextField];
                        [fadelertView showAlertWith:@"\n  登录成功  \n"];
                        [self dismissViewControllerAnimated:YES completion:nil];
//                        [self obtainToken];//获取token
                        [MLLoginTools obtainToken];
                        
                    } else {
                        //                        NSLog(@"%@",error);
                        
                        NSString *str =[NSString stringWithFormat:@"%@",error];
                        if ([str containsString:@"username or password incorrect"]) {
                            [fadelertView showAlertWith:@"登录失败\n用户名或密码错误"];
                        }else if ([str containsString:@"Code=20002"]){
                            [fadelertView showAlertWith:@"登录失败\n请检查网络"];
                        }else{
                            [fadelertView showAlertWith:@"\n  登录失败  \n"];
                        }
                        [self textFieldShouldReturn:self.accountTextField];
                        
                        
                    }
                }];
                
            }
            
            
            
            
            
        }else{
            
            MLFadeAlertView *fadelertView = [[MLFadeAlertView alloc]init];
            [fadelertView showAlertWith:@"\n  账号或密码位数不够  \n"];
            
        }
        
        
        
        
    }else{
        MLFadeAlertView *fadelertView = [[MLFadeAlertView alloc]init];
        [fadelertView showAlertWith:@"\n  请输入账户名和密码  \n"];
    }
    
    
    
    
    
}

//点return收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.passwordTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];
    return YES;
}

-(void)LoginAgreementAction{
    //    UserRegisteredAgreementViewController *userRegisteredAgreementVC =[[UserRegisteredAgreementViewController alloc]init];
    //    [self presentViewController:userRegisteredAgreementVC animated:YES completion:nil];
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
        self.view.frame = CGRectMake(0, -height,MLScreenWidth, MLScreenHeight);
    }];
    
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = CGRectMake(0, 0, MLScreenWidth, MLScreenHeight);
    }];
    
}
//判断输入有空格没
-(BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
