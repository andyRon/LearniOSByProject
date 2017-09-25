//
//  ViewController.m
//  GCD(OC)
//
//  Created by andyron on 2017/9/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCach.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self GCD];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 150, 100)];
    
    [imageView setImageWithURL:[NSURL URLWithString:@"https://www.baidu.com/img/bdlogo.gif"]];
    
    [self.view addSubview:imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GCD(Grand Central Dispatch)
- (void)GCD{
    
    dispatch_queue_t queue = dispatch_queue_create("test", NULL);
    
    // 多一个a,异步
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 100; i++) {
            NSLog(@"--多线程--%d",i);
        }
        
        // 判断是否是在多线程运行环境
        BOOL isMulti = [NSThread isMultiThreaded];
        NSLog(@"%d",isMulti);
        if (isMulti) {
            NSLog(@"*********多线程***********");
        }
        
        // 将代码块中的工作转回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            // 判断是否是在主线程运行环境
            BOOL isMain = [NSThread isMainThread];
            if (isMain) {
                NSLog(@"*********主线程**********");
            }
            
        });
        
    });
    
    /*    // 通过此方式,还是运行在当前线程
     dispatch_sync(queue, ^{
     // 主线程
     });
     */
    for (int i = 0; i < 100; i++) {
        NSLog(@"--主线程--%d",i);
    }
}

@end
