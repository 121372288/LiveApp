//
//  UIImageView+MLExtensionLoadImage.h
//  LiveAPP
//
//  Created by 马磊 on 2016/10/19.
//  Copyright © 2016年 MLCode.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MLExtensionLoadImage)


- (void)loadImageForURL:(NSURL *)url;

- (void)loadImageForURLString:(NSString *)urlString;

@end
