//
//  MLProfileController.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/10.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "MLProfileController.h"

@interface MLProfileController ()

@end

@implementation MLProfileController

+ (instancetype)shareManager{
    static MLProfileController *handle =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle =[[MLProfileController alloc]init];
    });
    return handle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
