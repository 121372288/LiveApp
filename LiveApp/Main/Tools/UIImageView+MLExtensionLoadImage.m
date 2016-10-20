//
//  UIImageView+MLExtensionLoadImage.m
//  LiveAPP
//
//  Created by 马磊 on 2016/10/19.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import "UIImageView+MLExtensionLoadImage.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (MLExtensionLoadImage)

- (void)loadImageForURL:(NSURL *)url{
    [self sd_setImageWithURL:url];
}

- (void)loadImageForURLString:(NSString *)urlString{
    [self loadImageForURL:[NSURL URLWithString:urlString]];
}


@end
