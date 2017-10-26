//
//  CGImageGIFView.m
//  GIfDemo
//
//  Created by andyron on 2017/10/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "CGImageGIFView.h"

@implementation CGImageGIFView

-(instancetype)initWithGIFPath:(NSString *)path
{
    if (self = [super init]) {
        
        //设置gif的属性来获取gif的图片信息
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:@0 forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                    forKey:(NSString *)kCGImagePropertyGIFDictionary];
        //这个是拿到图片的信息
        gifRef = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], (CFDictionaryRef)gifProperties);
        //这个拿到的是图片的张数，一张gif其实内部是有好几张图片组合在一起的，如果是普通图片的话，拿到的数就等于1
        count = CGImageSourceGetCount(gifRef);
        
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.isAnimating = NO;
    }
    return self;
}

// 开始和结束
-(void)startGIF
{
    //开始动画，启动一个定时器，每隔一段时间调用一次方法，切换图片
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.12 target:self selector:@selector(play) userInfo:nil repeats:YES];
    }
    [timer fire];
    self.isAnimating = YES;
}
-(void)play
{
    index = index + 1;
    index=  index % count;
    //方法的内容是根据上面拿到的imageSource来获取gif内部的第几张图片，拿到后在进行layer重新填充
    CGImageRef currentRef = CGImageSourceCreateImageAtIndex(gifRef, index, (CFDictionaryRef)gifProperties);
    self.layer.contents = (id)CFBridgingRelease(currentRef);
}
-(void)stopGIF
{
    //停止定时器
    self.isAnimating = NO;
    [timer invalidate];
    timer = nil;
}


@end
