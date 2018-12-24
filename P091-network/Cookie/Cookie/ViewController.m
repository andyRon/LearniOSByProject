//
//  ViewController.m
//  Cookie
//
//  Created by andyron on 2017/9/23.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 准备NSURLRequest
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    // 请求前 设置Cookie
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"andyron" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"1587" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"andyron.com" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"andyron.com" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    // 请求
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // 请求后获取Cookie
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        NSLog(@"%@", cookie);
    }

}


@end
