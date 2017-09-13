//
//  ViewController.m
//  NSURLSession(block)
//
//  Created by andyron on 2017/9/13.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建session配置对象
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    //创建session对象
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    //添加任务
    NSURLSessionTask * task= [defaultSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response);
    }];
    //开始任务
    [task resume];
}


@end
