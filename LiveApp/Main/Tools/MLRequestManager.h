//
//  MLRequestManager.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/11.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MLRequestManagerMehtodGET     = 0,
    MLRequestManagerMehtodPOST    = 1,
} MLRequestManagerMehtod;

typedef void (^RequestDataCompeled)(NSData *data);//请求完成后将data输出
typedef void (^UpdateUI)();//请求结束,刷新UI
typedef void (^TransmissionError)(NSError *error);//传出error

@interface MLRequestManager : NSObject



+ (void)requestDataWithUrl:(NSString *)url
                  parametr:(NSDictionary *)parameter
                    header:(NSDictionary *)header
                    mehtod:(MLRequestManagerMehtod)method
                  compelet:(RequestDataCompeled)compele
                  updateUI:(UpdateUI)update
         transmissionError:(TransmissionError)transmissionError;


@end
