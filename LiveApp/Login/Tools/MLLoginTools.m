//
//  MLLoginTools.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLLoginTools.h"
#import<CommonCrypto/CommonDigest.h>//sha1验证

@implementation MLLoginTools

static MLLoginTools* _instance = nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [MLLoginTools shareInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    return [MLLoginTools shareInstance] ;
}


+ (BOOL)loginStatus{
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {
        MLUserModel *user = [MLUserModel defaultModel];
        user.userName = bUser.username;
        user.nickName =[bUser objectForKey:@"nickName"];
        BmobFile *file = (BmobFile*)[bUser objectForKey:@"headPortrait"];
        user.headPortrait = file.url ? file.url : @"";
        [self obtainToken];
        return true;
    } else {
        return false;
    }
}

+ (void)obtainToken{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a ];//时间戳
    NSString *str =[NSString stringWithFormat:@"%@%@%@",@"EGJFEktqU9",@"123456",timeString];//签名和时间戳拼接
    NSString *string = [self sha1:str];//签名加密后
    
    MLUserModel *user = [MLUserModel defaultModel];
    NSDictionary *param = @{
                            @"userId"     : user.userName,
                            @"name"       : user.nickName,
                            @"portraitUri": user.headPortrait
                            };
    NSDictionary *header = @{
                             @"App-Key"   : @"z3v5yqkbvvsi0",
                             @"Nonce"     : @"123456",
                             @"Timestamp" : timeString,
                             @"Signature" : string
                             };
    
    [MLRequestManager requestDataWithUrl:@"https://api.cn.ronghub.com/user/getToken.json" parametr:param header:header mehtod:MLRequestManagerMehtodPOST compelet:^(NSData *data) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"获取的token字典:%@",dic);
        user.token =dic[@"token"];
        [self requestUserInformation];//登录融云账号
    } updateUI:nil transmissionError:^(NSError *error) {
         NSLog(@"登录融云错误信息:%@",error);
    }];
    
}
/*签名加密*/
+ (NSString *) sha1:(NSString *)input{

    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

//用token登录融云
+ (void)requestUserInformation{
    [[RCIMClient sharedRCIMClient] connectWithToken:[MLUserModel defaultModel].token success:^(NSString *userId) {
    } error:^(RCConnectErrorCode status) {
        NSLog(@"错误代码:%ld",status);
    } tokenIncorrect:^{
        
    }];
}
@end
