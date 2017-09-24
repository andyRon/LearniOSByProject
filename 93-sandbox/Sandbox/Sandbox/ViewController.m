//
//  ViewController.m
//  Sandbox
//
//  Created by andyron on 2017/9/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    [self sandboxDir];
//    [self file_w];
//    [self file_r];
    
//    [self fileManager4];
    
//    NSLog(@"%@", [[NSBundle mainBundle] resourcePath]);

}

- (void)sandboxDir {
    //    1、获取程序的Home目录
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"home path:%@", homeDirectory);
    
    //    2、获取document目录
    NSArray *Documentspaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *Documentspath = [Documentspaths objectAtIndex:0];
    NSLog(@"Documents path:%@", Documentspath);
    
    //    3、获取Cache目录   Library/Caches
    NSArray *Cachepaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *Cachepath = [Cachepaths objectAtIndex:0];
    NSLog(@"Cache path:%@", Cachepath);
    
    //    4、获取Library目录
    NSArray *Librarypaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *Librarypath = [Librarypaths objectAtIndex:0];
    NSLog(@"Library path:%@", Librarypath);
    
    //    5、获取Tmp目录
    NSString *tmpDir = NSTemporaryDirectory();
    NSLog(@"tmpDir:%@", tmpDir);
}

- (void)file_w {
//    6、写入文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSArray *array = [[NSArray alloc] initWithObjects:@"内容",@"content",nil];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    [array writeToFile:filePath atomically:YES];
}

- (void)file_r {
//    7, 读取文件
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"testFile.txt"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"%@", array);
}

// 判断一个文件是否存在
- (void)fileManager1 {
    // 创建文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [documents stringByAppendingPathComponent:@"testFile.txt"];
    
    // 判断一个文件是否存在,传入全路径
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"it is exit");
    }
}

// 创建目录和文件
- (void)fileManager2 {
    // 在Documents里创建目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory: %@",documentsDirectory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    
    // 在目录下创建文件
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test00.txt"];
    NSString *testPath2 = [testDirectory stringByAppendingPathComponent:@"test22.txt"];
    NSString *testPath3 = [testDirectory stringByAppendingPathComponent:@"test33.txt"];
    NSString *string = @"写入内容，write String";
    [fileManager createFileAtPath:testPath contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath2 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath3 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
}

// 获取目录列里所有文件名
- (void)fileManager3 {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory: %@",documentsDirectory);
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: myDirectory error:nil];
    NSLog(@"%@",file);
    NSArray *file2 = [fileManage subpathsAtPath: myDirectory ];
    NSLog(@"%@",file2);
}

// 更改到指定目录下操作
- (void)fileManager4 {
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    //创建文件fileName文件名称，contents文件的内容，如果开始没有内容可以设置为nil，attributes文件的属性，初始为nil
    NSString * fileName = @"testFileNSFileManager.txt";
    NSArray *array = [[NSArray alloc] initWithObjects:@"hello world",@"hello world1", @"hello world2",nil];
    [fileManager createFileAtPath:fileName contents:[NSKeyedArchiver archivedDataWithRootObject:array] attributes:nil];
    
//     删除文件
//    [fileManager removeItemAtPath:fileName error:nil];
}


@end
