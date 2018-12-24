//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by andyron on 2017/9/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

#import "UIImageView+WebCache.h"
//#import "SDWebImageManager.h"
//#import "SDWebImageDownloader.h"
//#import "UIImage+GIF.h"
//#import "NSData+ImageContentType.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"http://img4.duitang.com/uploads/blog/201310/18/20131018213446_smUw4.thumb.600_0.jpeg"];
    
//    [self.imageView sd_setImageWithURL: url];
    
//    [self.imageView sd_setImageWithURL: url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"图片加载完");
//    }];
    

//    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"]];
//
//    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"图片加载完");
//    }];
//
//    // 除了带options选项的方法，其他的方法都是综合存储，也就是内存缓存和磁盘缓存结合的方式，如果你只需要内存缓存，那么在options这里选择SDWebImageCacheMemoryOnly就可以了。
//    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"] options: SDWebImageCacheMemoryOnly];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //计算当前图片的下载进度
        NSLog(@"下载进度:%.2f",1.0 *receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
    
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    [manager loadImageWithURL:url options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    //计算当前图片的下载进度
    //NSLog(@"%.2f",1.0 *receivedSize / expectedSize);
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//        NSLog(@"图片加载完");
//    }];
    
    NSInteger *cacheSize = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"缓存大小：%d", cacheSize);

    // 查看缓存完整目录
    NSLog(@"%s__%d__|%@",__FUNCTION__,__LINE__,[[SDImageCache sharedImageCache] defaultCachePathForKey:@"http://img4.duitang.com/uploads/blog/201310/18/20131018213446_smUw4.thumb.600_0.jpeg"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
