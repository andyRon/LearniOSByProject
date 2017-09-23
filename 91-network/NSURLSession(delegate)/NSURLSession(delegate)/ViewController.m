//
//  ViewController.m
//  NSURLSession(delegate)
//
//  Created by andyron on 2017/9/13.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self config1];
    
    [self config2];
NSURLCache
    
}

- (void)config1
{
    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask * task= [defaultSession dataTaskWithRequest:request];
    
    [task resume];
}

- (void)config2
{
    NSURLSessionConfiguration * backgroundConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.andyron.NSURLSession-delegate-"];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSURLSession *  backgroundSession   = [NSURLSession sessionWithConfiguration:backgroundConfiguration delegate:self delegateQueue:nil];
    [[backgroundSession downloadTaskWithRequest:request]resume];
}

//开始接受数据
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"=======%@",data);
}
//接受数据结束
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"完成：error%@",error);
}

// 下载进度监听
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"######");
}

//此方法只有下载成功才会调用， 文件放在location位置
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载临时文件的位置%@", location);
}

// 后台所有任务都完成
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"All tasks are finished");
}

@end
