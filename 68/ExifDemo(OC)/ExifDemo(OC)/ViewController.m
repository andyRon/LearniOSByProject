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
    
    CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    
    NSDictionary *exifDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyExifDictionary);
    
    
    NSLog(@"EXIF:%@",exifDic);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
