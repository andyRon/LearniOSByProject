//
//  ViewController.m
//  NSOperationQueue(OC)
//
//  Created by andyron on 2017/9/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test5];
}

#pragma mark - NSBlockOperation
- (void)test4{
    
    NSOperationQueue * threadQueue = [[NSOperationQueue alloc] init];
    // Block真心方便
    [threadQueue addOperationWithBlock:^{
        
        for (int i =0; i <100; i++) {
            NSLog(@"--多线程--%d",i);
        }
    }];
    
    for (int i =0; i <100; i++) {
        NSLog(@"--主线程--%d",i);
    }
    
//    [threadQueue release];
}

#pragma mark - NSInvocationOperation
- (void)test5{
    
    //创建一个线程队列
    NSOperationQueue * threadQueue = [[NSOperationQueue alloc]init];
    
    //设置线程执行的并发数( -1 代表没有限制)
    threadQueue.maxConcurrentOperationCount = 1;
    
    //创建一个线程操作对象
    NSInvocationOperation * threadOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(mutableThread5)object:nil];
    
    //设置线程操作对象的优先级
    threadOperation.queuePriority = NSOperationQueuePriorityVeryHigh;
    
    //可添加多个,还有一个添加数组对象的方法
    [threadQueue addOperation:threadOperation];
    
    for (int i =0; i <100; i++) {
        NSLog(@"--主线程--%d",i);
    }
    
//    [threadOperation release];
//    [threadQueue release];
}

- (void)mutableThread5{
    
    for (int i =0; i <100; i++) {
        NSLog(@"--多线程--%d",i);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
