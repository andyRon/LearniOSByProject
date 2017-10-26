//
//  CGImageGIFView.h
//  GIfDemo
//
//  Created by andyron on 2017/10/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGImageGIFView : UIView
{
    //gif的字典属性，定义了gif的一些特殊内容，这里虽然设置了，但是没啥特殊设置，一般情况下可以设置为NULL
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    CGImageSourceRef gifRef;
    NSTimer *timer;
    
}

@property (nonatomic,assign,readwrite) BOOL isAnimating;

-(instancetype)initWithGIFPath:(NSString *)path;

-(void)startGIF;
-(void)stopGIF;

@end
