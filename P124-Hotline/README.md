Hotline
--------

分类：CallKit

了解您的应用如何使用CallKit进行系统级手机集成，以及如何构建用于呼叫阻止和识别的号码簿扩展。



VoIP (Voice over IP) app developers

学习到：
- Uses system services to report **incoming** and **outgoing** calls.
- Manages a call directory to identify or block incoming calls.

> 必须使用真机



### 开始程序

![](https://upload-images.jianshu.io/upload_images/1678135-c34a6c193d7a4729.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`Call` 代表电话呼叫类。包括识别呼叫的属性（比如`UUID`，`handle`等）。

`CallManage`  管理当前应用进行的呼叫列表。它有方法用于添加和删除呼叫。可以扩展这个类，来实现更多功能。




## CallKit介绍

`CallKit`是一个旨在通过允许应用程序与本机电话UI集成来改善VoIP体验的框架。

在锁屏和解屏下，使用原生呼叫界面。

调用原生phone应用中的**通讯录**，**个人收藏**，**个人收藏**。

系统不同呼叫间的交互。



`CallKit`的结构：

![](https://upload-images.jianshu.io/upload_images/1678135-df46094e9c3915e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`CXProvider`   `CXCallController`



`CXProvider`

### Incoming Calls

![](https://upload-images.jianshu.io/upload_images/1678135-5bba078d8ab9dada.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### ProviderDelegate



### CXProviderDelegate



### Test Flight



