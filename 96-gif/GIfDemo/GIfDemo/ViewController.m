//
//  ViewController.m
//  GIfDemo
//
//  Created by andyron on 2017/10/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"
#import "CGImageGIFView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadGIFWithCGImage];    
}

-(void)loadGIFWithWebView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 350, 200)];
    [webView setCenter:self.view.center];
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"dk" ofType:@"gif"]];
    webView.userInteractionEnabled = NO;
    [webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
    //设置webview背景透明，能看到gif的透明层
    webView.backgroundColor = [UIColor blackColor];
    webView.opaque = NO;
    [self.view addSubview:webView];
}

-(void)loadGIFWithCGImage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dk" ofType:@"gif"];
    CGImageGIFView *gifView = [[CGImageGIFView alloc] initWithGIFPath:path];
    [gifView setCenter:self.view.center];
    
    [self.view addSubview:gifView];
    [gifView startGIF];
}


@end
