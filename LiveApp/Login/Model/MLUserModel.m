//
//  MLUserModel.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/12.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLUserModel.h"

@implementation MLUserModel

static MLUserModel* _instance = nil;

+ (instancetype)defaultModel{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [MLUserModel defaultModel] ;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    return [MLUserModel defaultModel] ;
}

@end
