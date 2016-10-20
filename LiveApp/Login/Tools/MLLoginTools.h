//
//  MLLoginTools.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLLoginTools : NSObject

+ (instancetype)shareInstance;

+ (BOOL)loginStatus;
+ (void)obtainToken;
@end
