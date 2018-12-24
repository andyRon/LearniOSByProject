network
--------

网络基础例子



## iOS网络编程(一)：NSURLSession介绍


> [NSURLSession](https://developer.apple.com/documentation/foundation/nsurlsession?language=objc)是iOS7之后被用来代替NSURLConnection的网络开发框架，前者相对于后者的优势是支持后台处理能力


<!-- more -->


### NSURLSession的配置
通过`NSURLSessionConfiguration`来配置Session的三种类型：
- Default：提供前台请求相关方法，支持配置缓存，身份凭证等。

        NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

-  Ephemeral类型：即时的请求类型，不使用缓存，身份凭证等。

        NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        
- Background：后台类型，支持在后台完成请求任务。

      NSURLSessionConfiguration * backgroundConfiguration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.andyron.NSURLSession-delegate-"];

    `backgroundSessionConfigurationWithIdentifier`只是标识符。


`NSURLSessionConfiguration`还可以配置如缓存，网络模式等参数。

### `NSURLSession`的两种进行网络请求方式

1. 通过block的方式获取网络数据
```
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
```
  在block中进行数据处理

2. 通过代理回调获取网络数据

 + 首先采用协议 `NSURLSessionDataDelegate`
    ```
    @interface ViewController ()<NSURLSessionDataDelegate>

    @end
    ```
+ 配置
     ```
        NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSURLSessionTask * task= [defaultSession dataTaskWithRequest:request];
        
        [task resume];
    ```
+ 实现代理方法
     ```
        //开始接受数据
        -(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
            NSLog(@"=======%@",data);
        }
        //接受数据结束
        -(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
            NSLog(@"完成：error%@",error);
        }
    ```

### 后台处理下载任务
这是NSURLSession最大的优势。使用代理的方式进行后台处理下载任务。配置和代理方式相同，主要是实现一些代理方法。
- 下载进度监听的代理方法：
```
// 下载进度监听
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"######");
}
```
- 在下载过程中点击Home键使应用程序进入后台，下载任务依然在进行，当后台下载完成后会与AppDelegate进行交互，会调用AppDelegate中的代理方法
```
-(void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler{
    NSLog(@"下载任务在后台完成");
}
```
- 下载完成后，可查看下载的文件所在位置
```
//此方法只有下载成功才会调用， 文件放在location位置
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"下载临时文件的位置%@", location);
}
```
- 在后台完成无人所有任务时调用
```
// 后台所有任务都完成
-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    NSLog(@"All tasks are finished");
}
```


> 代码：[NSURLSession(delegate), NSURLSession(block)](https://github.com/andyRon/LearniOSByProject/tree/master/P091-network)
> 深入学习：[URL Session Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html#//apple_ref/doc/uid/10000165i)

> 参考
[iOS网络编程之二——NSURLSession的简单使用](https://my.oschina.net/u/2340880/blog/618888?spm=5176.100239.blogcont39440.7.Snsasi)




## iOS网络编程(二)：NSURLConnection介绍



> [NSURLConnection](https://developer.apple.com/documentation/foundation/nsurlconnection)在iOS7之后基本被NSURLSession，但为了兼容，有必要学习一下。

网络请求分为同步和异步两种：
- 同步是指在请求结果返回之前，程序代码会卡在请求处，之后的代码不会被执行，请求返回结果后，之后的代码再执行。
- 异步是指在发送请求之后，一边在子线程中接收返回数据，一边执行之后的代码，当返回数据接收完毕后，采用回调的方式通知主线程做处理。


<!-- more -->


### 一、NSURLConnection同步请求

```
// 同步
- (void)tongbu {
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",data);
    NSLog(@"继续执行");
}
```

### 而、NSURLConnection异步请求

1. block方式的异步请求
```
// block的异步
- (void)yibu {
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //其中的queue参数决定block中的代码在哪个队列中执行
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",data);
    }];
    NSLog(@"继续执行");
}
```
2. 代理回调方式的异步请求
采用协议和声明一个用户接受数据的可变NSData：
```
@interface ViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData * _data;
}
```

请求代码：
```
// 代理回调的异步
- (void)yibu_delegate {
    _data = [[NSMutableData alloc]init];
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
```

实现代理方法：
```
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //开始接收数据
    [_data setLength:0];
    NSLog(@"%s","开始接收数据");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //正在接收数据
    [_data appendData:data];
    NSLog(@"%s","正在接收数据");
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //接收数据失败
    NSLog(@"%@",error);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //接收数据完成
    NSLog(@"%@",_data);
}
```


> 代码：[NSURLConnection](https://github.com/andyRon/LearniOSByProject/tree/master/P091-network)

> 参考：[iOS网络编程之三——NSURLConnection的简单使用](https://yq.aliyun.com/articles/39436)



## iOS网络编程(三)：请求类NSURLRequest和请求响应类NSURLResponse介绍




NSURLSession和NSURLConnection框架，网络请求都是通过NSURLRequest类发起的。

NSURLRequest请求类除了在初始化时可以设定一些属性，创建出来后则大部分属性都为只读的，无法设置与修改。`NSMutableURLRequest`相对而言可以更加灵活的设置请求的相关属性（属性修饰符变化），其他方面没有多少区别。


<!-- more -->


### 一、NSURLRequest类中常用方法和属性
类方法：
```
// 创建的请求对象 默认使用NSURLRequestUseProtocolCachePolicy缓存逻辑 默认请求超时时限为60s
+ (instancetype)requestWithURL:(NSURL *)URL;

// 创建的请求对象 创建时设置缓存逻辑和超时时限
+ (instancetype)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;
```

实例方法：
```
// init方法进行对象的创建 默认使用NSURLRequestUseProtocolCachePolicy缓存逻辑 默认请求超时时限为60s
- (instancetype)initWithURL:(NSURL *)URL;

// init方法进行对象的创建
- (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;
```

属性：
```
// 判断是否支持安全编码
@property (class, readonly) BOOL supportsSecureCoding;

// 只读属性 获取请求对象的URL
@property (nullable, readonly, copy) NSURL *URL;

// 只读属性 缓存策略
@property (readonly) NSURLRequestCachePolicy cachePolicy;

//只读属性 获取请求的超时时限
@property (readonly) NSTimeInterval timeoutInterval;

//主文档地址 这个地址用来存放缓存
@property (nullable, readonly, copy) NSURL *mainDocumentURL;

// 获取网络请求的服务类型
@property (readonly) NSURLRequestNetworkServiceType networkServiceType;

//获取是否允许使用服务商蜂窝网络
@property (readonly) BOOL allowsCellularAccess;

```

缓存策略`NSURLRequestCachePolicy`:
```
typedef NS_ENUM(NSUInteger, NSURLRequestCachePolicy)
{

    //默认的缓存协议

    NSURLRequestUseProtocolCachePolicy = 0,

    //无论有无本地缓存数据 都进行从新请求

    NSURLRequestReloadIgnoringLocalCacheData = 1,

    //忽略本地和远程的缓存数据 未实现的策略

    NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4, 

    //无论有无缓存数据 都进行从新请求

    NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,

    //先检查缓存 如果没有缓存再进行请求

    NSURLRequestReturnCacheDataElseLoad = 2,

    //类似离线模式，只读缓存 无论有无缓存都不进行请求

    NSURLRequestReturnCacheDataDontLoad = 3,

    //未实现的策略

    NSURLRequestReloadRevalidatingCacheData = 5, // Unimplemented
};
```


网络请求的服务类型枚举`NSURLRequestNetworkServiceType`:
```
typedef NS_ENUM(NSUInteger, NSURLRequestNetworkServiceType)
{

    NSURLNetworkServiceTypeDefault = 0,   // Standard internet traffic

    NSURLNetworkServiceTypeVoIP = 1,  // Voice over IP control traffic

    NSURLNetworkServiceTypeVideo = 2, // Video traffic

    NSURLNetworkServiceTypeBackground = 3, // Background traffic

    NSURLNetworkServiceTypeVoice = 4     // Voice data
};
```


### 二、与HTTP/HTTPS协议相关请求的属性和方法
这些属性属于`NSMutableURLRequest`:

```
// HPPT请求方式 默认为“GET”
@property (copy) NSString *HTTPMethod;

//通过字典设置HTTP请求头的键值数据
@property (nullable, copy) NSDictionary<NSString *, NSString *> *allHTTPHeaderFields;

//设置http请求头中的字段值
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;

//向http请求头中添加一个字段
- (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

//设置http请求体 用于POST请求
@property (nullable, copy) NSData *HTTPBody;

//设置http请求体的输入流
@property (nullable, retain) NSInputStream *HTTPBodyStream;

//设置发送请求时是否发送cookie数据
@property BOOL HTTPShouldHandleCookies;

//设置请求时是否按顺序收发 默认禁用 在某些服务器中设为YES可以提高网络性能
@property BOOL HTTPShouldUsePipelining;
```


### 三、NSURLResponse

网络请求成功后，服务器响应信息会存存放在`NSURLResponse`和其子类`NSHTTPURLResponse`中:

```
//请求的URL地址
@property (nullable, readonly, copy) NSURL *URL;

//返回数据的数据类型
@property (nullable, readonly, copy) NSString *MIMEType;

//获取返回数据的内容长度
@property (readonly) long long expectedContentLength;

//获取返回数据的编码方式
@property (nullable, readonly, copy) NSString *textEncodingName;

//返回拼接的数据文件名 以url为名 数据没醒MIMEType为扩展名
@property (nullable, readonly, copy) NSString *suggestedFilename;

//请求的状态码
@property (readonly) NSInteger statusCode;

//请求头中所有的字段
@property (readonly, copy) NSDictionary *allHeaderFields;
```


> 参考：[iOS网络编程之四——请求类NSURLRequest使用详解](https://yq.aliyun.com/articles/39440)
[iOS网络编程之五——请求回执类NSURLResponse属性简介](https://yq.aliyun.com/articles/39442)




##  iOS网络编程(四)：缓存类NSURLCache介绍





网络请求中缓存类`NSURLCache`常用属性和方法：

<!-- more -->

```
//获取当前应用的缓存管理对象
+ (NSURLCache *)sharedURLCache;

//设置自定义的NSURLCache作为应用缓存管理对象
+ (void)setSharedURLCache:(NSURLCache *)cache;

//初始化一个应用缓存对象
/*
memoryCapacity 设置内存缓存容量
diskCapacity 设置磁盘缓存容量
path 磁盘缓存路径
内容缓存会在应用程序退出后 清空 磁盘缓存不会
*/
- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(nullable NSString *)path;

//获取某一请求的缓存
- (nullable NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request;

//给请求设置指定的缓存
- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request;

//移除某个请求的缓存
- (void)removeCachedResponseForRequest:(NSURLRequest *)request;

//移除所有缓存数据
- (void)removeAllCachedResponses;

//移除某个时间起的缓存设置
- (void)removeCachedResponsesSinceDate:(NSDate *)date NS_AVAILABLE(10_10, 8_0);

//内存缓存容量大小
@property NSUInteger memoryCapacity;

//磁盘缓存容量大小
@property NSUInteger diskCapacity;

//当前已用内存容量
@property (readonly) NSUInteger currentMemoryUsage;

//当前已用磁盘容量
@property (readonly) NSUInteger currentDiskUsage;
```

> 参考：[iOS网络编程之六——数据缓存类NSURLCache使用解析](https://yq.aliyun.com/articles/39448)




## iOS网络编程(五)：Cookie的使用



Cookie在Web开发时是非常常用的客户端（浏览器）保存少量信息一种方法。
Cookie是网站为了便是终端身份，保存在终端本地的用户凭证信息。Cookie中的字段与意义由服务端进行定义。例如，当用户在某个网站进行了登录操作后，服务端会将Cookie信息返回给终端，终端会将这些信息进行保存，在下一次再次访问这个网站时，终端会将保存的Cookie信息一并发送到服务端，服务端根据Cookie信息是否有效来判断此用户是否可以自动登录。

在iOS同样也有Cookie，Cookie管理的有两个类：`NSHTTPCookieStorage` 和 `NSHTTPCookie `。


<!-- more -->



### 获取Cookie
在请求后获取Cookie

```
NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
for (NSHTTPCookie *cookie in [cookieJar cookies]) {
   NSLog(@"%@", cookie);
}
```

例如请求百度后，就会返回几个如下Cookie对象(`NSHTTPCookie`):

```
<NSHTTPCookie
    version:0
    name:BD_NOT_HTTPS
    value:1
    expiresDate:'2017-09-23 14:14:22 +0000'
    created:'2017-09-23 14:09:22 +0000'
    sessionOnly:FALSE
    domain:www.baidu.com
    partition:none
    path:/
    isSecure:FALSE
 path:"/" isSecure:FALSE>
```

### 设置Cookie
在请求前设置一个如下Cookie：

```
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
```

在请求后获取的几个Cookie对象（服务器本身设置的和服务器从客户端后去的）中就有如下一个：

```
<NSHTTPCookie
    version:0
    name:andyron
    value:1587
    expiresDate:'(null)'
    created:'2017-09-23 14:43:52 +0000'
    sessionOnly:TRUE
    domain:andyron.com
    partition:none
    path:/
    isSecure:FALSE
 path:"/" isSecure:FALSE>
```

### NSHTTPCookieStorage方法和属性介绍

```
//获取单例对象
+ (NSHTTPCookieStorage *)sharedHTTPCookieStorage;

//所有Cookie数据数组 其中存放NSHTTPCookie对象
@property (nullable , readonly, copy) NSArray<NSHTTPCookie *> *cookies;

//手动设置一条Cookie数据
- (void)setCookie:(NSHTTPCookie *)cookie;

//删除某条Cookie信息
- (void)deleteCookie:(NSHTTPCookie *)cookie;

//删除某个时间后的所有Cookie信息 iOS8后可用
- (nullable NSArray<NSHTTPCookie *> *)cookiesForURL:(NSURL *)URL;

//获取某个特定URL的所有Cookie数据
- (void)removeCookiesSinceDate:(NSDate *)date NS_AVAILABLE(10_10, 8_0);

//为某个特定的URL设置Cookie
- (void)setCookies:(NSArray<NSHTTPCookie *> *)cookies forURL:(nullable NSURL *)URL mainDocumentURL:(nullable NSURL *)mainDocumentURL;

//Cookie数据的接收协议
/*
枚举如下：
typedef NS_ENUM(NSUInteger, NSHTTPCookieAcceptPolicy) {

    NSHTTPCookieAcceptPolicyAlways,//接收所有Cookie信息

    NSHTTPCookieAcceptPolicyNever,//不接收所有Cookie信息

    NSHTTPCookieAcceptPolicyOnlyFromMainDocumentDomain//只接收主文档域的Cookie信息
};
*/
@property NSHTTPCookieAcceptPolicy cookieAcceptPolicy;
```

与Cookie相关的通知：

```
//Cookie数据的接收协议改变时发送的通知
FOUNDATION_EXPORT NSString * const NSHTTPCookieManagerAcceptPolicyChangedNotification;

//管理的Cookie数据发生变化时发送的通知
FOUNDATION_EXPORT NSString * const NSHTTPCookieManagerCookiesChangedNotification;
```

### NSHTTPCookie的方法和属性介绍

`NSHTTPCookie`就是Cookie对象。

```
//下面两个方法用于对象的创建和初始化 都是通过字典进行键值设置
- (nullable instancetype)initWithProperties:(NSDictionary<NSString *, id> *)properties;
+ (nullable NSHTTPCookie *)cookieWithProperties:(NSDictionary<NSString *, id> *)properties;

//返回Cookie数据中可用于添加HTTP头字段的字典
+ (NSDictionary<NSString *, NSString *> *)requestHeaderFieldsWithCookies:(NSArray<NSHTTPCookie *> *)cookies;

//从指定的响应头和URL地址中解析出Cookie数据
+ (NSArray<NSHTTPCookie *> *)cookiesWithResponseHeaderFields:(NSDictionary<NSString *, NSString *> *)headerFields forURL:(NSURL *)URL;

//Cookie数据中的属性字典
@property (nullable, readonly, copy) NSDictionary<NSString *, id> *properties;

//请求响应的版本
@property (readonly) NSUInteger version;

//请求相应的名称
@property (readonly, copy) NSString *name;

//请求相应的值
@property (readonly, copy) NSString *value;

//过期时间
@property (nullable, readonly, copy) NSDate *expiresDate;

//请求的域名
@property (readonly, copy) NSString *domain;

//请求的路径
@property (readonly, copy) NSString *path;

//是否是安全传输
@property (readonly, getter=isSecure) BOOL secure;

//是否只发送HTTP的服务
@property (readonly, getter=isHTTPOnly) BOOL HTTPOnly;

//响应的文档
@property (nullable, readonly, copy) NSString *comment;

//相应的文档URL
@property (nullable, readonly, copy) NSURL *commentURL;

//服务端口列表
@property (nullable, readonly, copy) NSArray<NSNumber *> *portList;
```

> 代码：[Cookie](https://github.com/andyRon/LearniOSByProject/tree/master/P091-network)


> 参考：[ IOS中http请求使用cookie](http://rainbird.blog.51cto.com/211214/805173/)
[iOS网络编程之七——本地用户凭证Cookie的应用](https://yq.aliyun.com/articles/39450?spm=5176.8091938.0.0.J0bmQO)




## iOS网络编程(六)：SDWebImage的简单使用



![](http://upload-images.jianshu.io/upload_images/1678135-27a4683256504565.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


**SDWebImage**一些知识：
- 对远程图片进行缓存管理（磁盘+内存）
- 异步加载
- 同一个URL图片不会重复下载
- 失效的URL不会被无限重试



<!-- more -->


### 图片加载一般使用


- **SDWebImage**通过为`UIImageView`添加类别，扩展了一些类似的方法，只是参数的多少数目不同，最全的参数的方法是：

  ```
    -sd_setImageWithURL:placeholderImage:options:progress:completed:
  ```
    + `sd_setImageWithURL`: `URL`的图片的URL
    + `placeholderImage`:  远程图片没有加载完成的占位图片
    + `options`: 一个位移枚举(`SDWebImageOptions`)，可以通过按位或 | 来并列添加参数。`SDWebImageOptions`的所有选项如下
      ```
            //失败后重试
            SDWebImageRetryFailed   =   1   <<   0,
             
            //UI交互期间开始下载，导致延迟下载比如UIScrollView减速。
            SDWebImageLowPriority   =   1   <<   1,
             
            //只进行内存缓存
            SDWebImageCacheMemoryOnly   =   1   <<   2,
             
            //这个标志可以渐进式下载,显示的图像是逐步在下载
            SDWebImageProgressiveDownload   =   1   <<   3,
             
            //刷新缓存
            SDWebImageRefreshCached   =   1   <<   4,
             
            //后台下载
            SDWebImageContinueInBackground   =   1   <<   5,
             
            //NSMutableURLRequest.HTTPShouldHandleCookies   =   YES;
            SDWebImageHandleCookies   =   1   <<   6,
             
            //允许使用无效的SSL证书
            //SDWebImageAllowInvalidSSLCertificates   =   1   <<   7,
             
            //优先下载
            SDWebImageHighPriority   =   1   <<   8,
             
            //延迟占位符
            SDWebImageDelayPlaceholder   =   1   <<   9,
             
            //改变动画形象
            SDWebImageTransformAnimatedImage   =   1   <<   10,
      ```
    + `progress`: `Block` 获取当前图片数据的下载进度
         receivedSize：已经下载完成的数据大小
         expectedSize：该文件的数据总大小
    + `completed`: `Block`加载完
         image:下载得到的图片数据
         error:下载出现的错误信息
         SDImageCacheType：图片的缓存策略
         imageURL：下载的图片的url地址

  
- 引入**UIImageView+WebCache**类别就可以使用**SDWebImage**加载图片
```
#import "UIImageView+WebCache.h"
```

- 不同参数方法使用🌰
```
    [self.imageView sd_setImageWithURL: url];
    
    [self.imageView sd_setImageWithURL: url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"图片加载完");
    }];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"]];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"图片加载完");
    }];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"apple"] options: SDWebImageCacheMemoryOnly];

    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //计算当前图片的下载进度
        NSLog(@"下载进度:%.2f",1.0 *receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
```

### 图片加载过程
![](http://upload-images.jianshu.io/upload_images/656644-7dfe370a86e157e7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 缓存大小
```
    NSInteger *cacheSize = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"缓存大小：%d", cacheSize);
```

### 清理缓存
```
// 清理内存缓存
[[SDImageCache sharedImageCache] clearMemory];

// 清理磁盘缓存
[[SDImageCache sharedImageCache] clearDisk];
```

###   查看缓存完整目录
```
NSLog(@"%s__%d__|%@",__FUNCTION__,__LINE__,[[SDImageCache sharedImageCache] defaultCachePathForKey:@"http://img4.duitang.com/uploads/blog/201310/18/20131018213446_smUw4.thumb.600_0.jpeg"]);
```

> 代码：[SDWebImageDemo](https://github.com/andyRon/LearniOSByProject/tree/master/P091-network)

> 参考：
[iOS图片加载框架－SDWebImage解读](http://www.jianshu.com/p/be9a0a088feb)
[SDWebImage 的简单使用方法](http://www.cnblogs.com/yevgeni/articles/5582840.html)
[iOS开发SDWebImage的基本使用](http://www.cnblogs.com/cqb-learner/p/5856850.html)