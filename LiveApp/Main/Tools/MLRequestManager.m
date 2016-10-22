//
//  MLRequestManager.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLRequestManager.h"

@implementation MLRequestManager

+ (void)requestDataWithUrl:(NSString *)url parametr:(NSDictionary *)parameter header:(NSDictionary *)header mehtod:(MLRequestManagerMehtod)method compelet:(RequestDataCompeled)compele updateUI:(UpdateUI)update transmissionError:(TransmissionError)transmissionError{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    if (header) {//如果有头部数据  则遍历传入数据
        [header enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [manager.requestSerializer  setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    switch (method) {
        case MLRequestManagerMehtodGET:
        {
            [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (compele) { //把data传出去
                compele((NSData *)responseObject);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (update) {//刷新UI
                        update();
                    }

                });
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (transmissionError) {
                transmissionError((NSError *)error);//传出错误信息
                }
                if (update) {
                    update();//刷新UI
                }
            }];
            break;
        }
        case MLRequestManagerMehtodPOST:
        {
            [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (compele) { compele((NSData *)responseObject); }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (update) {
                        update();
                    }
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (transmissionError) {
                transmissionError((NSError *)error);
                }
                if (update) {
                update();
                }
            }];
            break;
        }
    }
    
}

@end
