//
//  ViewController.m
//  NSURLConnection
//
//  Created by andyron on 2017/9/17.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData * _data;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

// 同步
- (void)tongbu {
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",data);
    NSLog(@"继续执行");
}

- (void)yibu {
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //其中的queue参数决定block中的代码在哪个队列中执行
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",data);
    }];
    NSLog(@"继续执行");
}

- (void)yibu_delegate {
    _data = [[NSMutableData alloc]init];
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //开始接收数据
    [_data setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //正在接收数据
    [_data appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //接收数据失败
    NSLog(@"%@",error);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //接收数据完成
    NSLog(@"%@",_data);
}

@end
