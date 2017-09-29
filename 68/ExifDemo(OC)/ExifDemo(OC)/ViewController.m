//
//  ViewController.m
//  ExifDemo(OC)
//
//  Created by andyron on 2017/6/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 获取图片文件
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"IMG_0845" withExtension:@"JPG"];
    // 创建CGImageSourceRef
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    
    // 利用imageSource获取全部ExifData
    CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    
    // 从全部ExifData中取出EXIF文件
    NSDictionary *exifDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyExifDictionary);
    
    
    NSLog(@"EXIF:%@",exifDic);
    
    
}


@end
