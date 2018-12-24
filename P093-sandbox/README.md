## iOS沙盒和文件管理


![](http://upload-images.jianshu.io/upload_images/1678135-423ab6158c3ad6b2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


**沙盒**（sandbox）：iOS系统为每个应用程序创建自己的目录，每个应用程序只能访问自己的目录。
所有的非代码文件都要保存在此，例如图像，图标，声音，映像，属性列表，文本文件等。


<!-- more -->


### 在Mac的Finder上打开一个目录

由于有些目录比较长，不适合直接**Finder**里点击选取。有两种方法可以用：
1.  在**Finder**的菜单中选择  **前往 > 前往文件夹**

2. 在命令行中使用`open`命令：
    
        open /Users/andyron/Library/Developer/CoreSimulator/Devices/F03C84B3-2A5E-44A7-AA51-2142A6397CA7/data/Containers/Data/Application/E83106A7-FCF3-45A6-888E-330BC52B279B/


### 应用沙盒的完整目录

1. Xcode的模拟器的目录类似：
```
/Users/andyron/Library/Developer/CoreSimulator/Devices/F03C84B3-2A5E-44A7-AA51-2142A6397CA7/data/Containers/Data/Application/E83106A7-FCF3-45A6-888E-330BC52B279B/
```

`Devices/F03C84B3-2A5E-44A7-AA51-2142A6397CA7`是Xcode中不同模拟器的区别字符

2. 真机中类似：
```
/var/mobile/Containers/Data/Application/9AC577C1-08B2-4BAE-9CE2-1211E4994F9E/
```

类似`Application/9AC577C1-08B2-4BAE-9CE2-1211E4994F9E/`这个目录就是每个应用沙盒的根目录。

沙盒中目录结构类似如下：
```
├── Documents
├── Library
│   ├── Caches
│   │   └── Snapshots
│   │       └── com.andyron.Sandbox
│   │           ├── 9EEA412B-07C1-44EC-995B-0C12AD87BAF9@2x.ktx
│   │           └── D3F89052-27FD-42A1-B246-B416E1772FBB@2x.ktx
│   └── Preferences
├── SystemData
└── tmp
```
+ 默认情况下，每个沙盒含有3个文件夹：Documents, Library 和 tmp。因为应用的沙盒机制，应用只能在几个目录下读写文件
+ `Documents`：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
+ `Library`：存储程序的默认设置或其它状态信息；
+ `Library/Caches`：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除
+ `tmp`：提供一个即时创建临时文件的地方。
+ iTunes在与iPhone同步时，备份所有的Documents和Library文件。
+ iPhone在重启时，会丢弃所有的tmp文件。

### 获取不同目录
```
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
```

### 文件的写入和读取
```
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
```

### 文件管理
文件管理器`NSFileManager`有判断文件是否存在、创建目录和文件、获取文件名、删除文件等功能。

1. 判断文件是否存在
```
    // 创建文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filePath = [documents stringByAppendingPathComponent:@"testFile.txt"];
    
    // 判断一个文件是否存在,传入全路径
    if ([fileManager fileExistsAtPath:filePath]) {
        NSLog(@"it is exit");
    }
```

2. 创建目录和文件
```
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
```

3. 获取目录列里所有文件名
`subpathsOfDirectoryAtPath` 和 `subpathsAtPath` 两个方法都可以。
```
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory: %@",documentsDirectory);
    
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: myDirectory error:nil];
    NSLog(@"%@",file);
    NSArray *file2 = [fileManage subpathsAtPath: myDirectory ];
    NSLog(@"%@",file2);
```

4. 更改到指定目录下操作
`changeCurrentDirectoryPath`方法。
```
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
```

5. 删除文件

```
[fileManager removeItemAtPath:fileName error:nil];
```

> 代码： [Sandbox](https://github.com/andyRon/LearniOSByProject/tree/master/P093-sandbox)

> 参考：
[沙盒机制与文件(一)](https://www.kancloud.cn/digest/data/106687)
[沙盒机制与文件(二)](https://www.kancloud.cn/digest/data/106688)
[沙盒机制与文件(三)](https://www.kancloud.cn/digest/data/106689)


