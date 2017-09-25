//
//  UIImageView+WebCach.m
//  GCD(OC)
//
//  Created by andyron on 2017/9/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "UIImageView+WebCach.h"

@implementation UIImageView (WebCach)

- (void)setImageWithURL:(NSURL *)url{
    
    dispatch_queue_t queue = dispatch_queue_create("loadImage", NULL);
    
    dispatch_async(queue, ^{
        
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        
        // 加载UI的操作,一般放在主线程进行
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.image = image;
        });
        
    });
}

@end
