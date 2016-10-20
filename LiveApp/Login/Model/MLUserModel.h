//
//  MLUserModel.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLUserModel : NSObject

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *nickName;

@property (nonatomic, strong) NSString *headPortrait;

@property (nonatomic, strong) NSString *token;

+ (instancetype)defaultModel;

@end
