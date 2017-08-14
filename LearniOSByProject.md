
-------

Third目录是第三方库和包的使用情况
### 学习来源
- http://www.appcoda.com/
- https://www.ioscreator.com/
- https://www.raywenderlich.com/
-------
### 1 StopWatch

### 2 project-2-CunstomFont
- 点击按钮然后改变字体

### 3 QRCodeReader 
- 扫描二维码or条形码，[原文](http://www.appcoda.com/barcode-reader-swift/)
- **AVFoundation framework**

### 4 Detector
- [参考文章](http://www.appcoda.com/face-detection-core-image/)
Face Detection in iOS Using Core Image

-  Core Image and UIView (or UIKit) use two different coordinate systems

### 5 SpeechToTextDemo
- 语音识别[参考文章](http://www.appcoda.com/siri-speech-framework/)
- **Speech framework**
- `Locale`的 identifier可参考 https://gist.github.com/jacobbubu/1836273
- https://developer.apple.com/videos/play/wwdc2016/509/

### 6 RequestingPermission
- [请求定位权限](http://swift.gg/2017/02/13/requesting-permissions-core-location-tutorial/)
- `CoreLocation`

### 7 LocalNotification
- http://swift.gg/2017/01/04/local-notification-tutorial-ios10/
- iOS账号续费及证书更新流程 ??
http://www.cnblogs.com/chimianduofangcong/p/5798657.html
http://zltunes.com/ios-10-tong-zhi-geng-xin-xiang-jie/

### 8 CAGradientLayer 
- [颜色渐变](http://www.appcoda.com/cagradientlayer/)
- Core Graphics 功能复杂一点
- CAGradientLayer 简单适合新手， radial gradient is not supported
- Gradient Direction
    + 这边的坐标系比较特殊： 左上角点是(0.0, 0.0)，右下角是(1.0, 1.0).
    + Mac系统的是: 左下角点是(0.0, 0.0)，右上角是(1.0, 1.0)

### 9 
?? http://www.appcoda.com/healthkit-introduction/


### 10 TwitterTutorial
- [参考](https://www.ioscreator.com/tutorials/twitter-ios-tutorial-ios10)
- 知识点
    + `Social`
    + `UIImagePickerController`, `UIImagePickerControllerSourceType`, `SLComposeViewController`
- 步骤
    1. 建立类型为**Single View Application**， product name为****
    2. 添加一个 **Image View**，属性**Content Mode**设置为*Aspect Fit*
    3. 添加两个按钮，*title*分别为"Choose Image" and "Tweet"
    4. 给**Image View**添加限制
    5. 给两个按钮添加一定限制
    6. 在**ViewController.swift**中，为**Image View**添加outlet，为两个按钮添加Action
    7. 使用**Social framework** : `import Social`
    8. `ViewController`  实现 `UINavigtionControllerDelegate` , `UiImagePickerControllerDelegate`
    9. 定义 `var pickerController: UIImagePickerController = UIImagePickerController()`，用于获取图片
    10. 实现方法`chooseImagePressed`
    ```
    @IBAction func chooseImagePressed(_ sender: UIButton) {
        
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        present(pickerController, animated: true, completion: nil)
    }
    ```
    11. 实现方法`tweetButtonPressed`
    ```
    @IBAction func tweetButtonPressed(_ sender: UIButton) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            
            if let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                
                tweetSheet.setInitialText("看着漂亮的图片了")
                tweetSheet.add(imageView.image)
                
                present(tweetSheet, animated: true, completion: nil)
            }
        } else {
            print("error")
        }
    }
    ```
    12. 实现代理方法`imagePickerController:didFinishPickingMediaWithInfo`
    13. 在**Inof.plist**中添加图库或相机使用key

### 11 CustomizeNavBarTutorial 
- 知识点
    + `UINavigationBar` 

### 12 ShadowButtonTutorial button的阴影

### 13 FadeMusicTutorial  音乐的声音的渐变
- 知识点
    + `AVFoundation` `AVAudioPlayer`

### 14 DatePickerTutorial 
- 知识点
    + `UIDatePicker`
    + `DateFormatter`

### 15 UIStepperTutorial 
- 知识点
    + `UIStepper`

### 16 SpriteKitBackgroundTutorial

### 17 DrawShapesTutorial
- 知识点
    + `CGContext`   `UIGraphicsGetCurrentContext()`

### 18 DrawGradientsTutorial
- 知识点
    + `CGGradient`

### 19 TabBarCustomizationTutorial
- 知识点
    + `UITabBarController`

### 20 ChangeDisplayNameTutorial  改变app在Home screen时的显示名
- 知识点
    +  **info.plist**中 **Bundle display name**,

### 21 OpenPDFTutorial


### 22 SpellingCheckerTutorial
- 知识点
    + Double-click on the Navigation Bar in The Table View Controller and set the title to "Choose the right spelling". 
    + `UITextChecker`  `rangeOfMisspelledWord()`

### 23 DraggingViewsTutorial
- 知识点
    + `UIPanGestureRecognizer`
    + `insetBy()`

### 24 VibrationTutorial   震动 

### 25 XMLParserTutorial
- 知识点
    + `XMLParser`

### 26 DrawRouteMapKitTutorial ??
- 知识点
    + `` 
- [参考](https://www.ioscreator.com/tutorials/draw-route-mapkit-tutorial)

### 27 MultipleOutletsTutorial
- 知识点
    + `UIView.subviews`
    + `UIControl.addTarget()`

### 28 SpriteKitPhysicsTutorial  ??
- [参考](https://www.ioscreator.com/tutorials/sprite-kit-physics-tutorial)

### 29 PlayMusicAVAudioPlayerTutorial

### 30 CoreSpotlightTutorial 

### 31 SwiftFileManagementTutorial  ?? 
try? ?
- [参考](https://www.ioscreator.com/tutorials/file-management-tutorial-ios8-swift)


### 32 SwiftCoreImageTutorial  图片滤镜
- 知识点
    + `CIImage`   保存图像数据的类
    + `CIFilter`   滤镜类 图片属性进行细节处理的类 它对所有的像素进行操作 用键-值 （KVC）来设置

### 33 ContextMenuTableViewTutorial   table的 cut/copy/paste操作
- 知识点
    + `UIResponderStandardEditActions`
    +  `tableView:shouldShowMenuForRowAtIndexPath`    `tableView:canPerformAction:forRowAtIndexPath`   `tableView:performAction:forRowAtIndexPath:withSender` 
    + `textFieldShouldReturn`

### 34 TextFieldAlertControllerTutorial

### 35 TakeVideoPlayerTutorial
- 知识点
    + `UIImagePickerControllerMediaType`
    + `Photos`框架 ??

### 36 SearchMapTutorial
- 知识点
    + `MKLocalSearchRequest`  `MKCoordinateSpan` `MKLocalSearch`

### 37 AirdropTutorial
- 知识点
    + `UIActivityViewController`
 
### 38 ReorderingCollectionViewTutorial

### 39 ScaleImagesTutorial
- 知识点
    + `UIPinchGestureRecognizer`  `CGAffineTransform`

### 40 UserDefaultsTutorial  程序被杀掉后数据还能保存
- 知识点
    + `UserDefaults`

### 41 ScreenEdgePanGesturesTutorial 屏幕边缘手势
- 知识点
    + `UIScreenEdgePanGestureRecognizer`

### 42 AddEventTutorial
- 知识点
    + `EventKit`  `EKEventStore`
    + 向日历中添加事件

### 43 ToadyExtension
- 知识点
    + `ProcessInfo().operatingSystemVersion`
    + **Application Extension**

### 44 AddSearchTableViewTutorial
- 知识点
    + `NSPredicate`
    + `UISearchResultsUpdating`
    + `UISearchController`
    + 闭包的一种写法

### 45 MoveViewKeyboardTutorial  ??
(https://www.ioscreator.com/tutorials/move-view-behind-keyboard-ios8-swift)


### 46 ScrollViewTutorial
- 知识点
    + `UIScrollView`

### 47 EmailTutorial

### 48 ActivityIndicatorStatusBarTutorial  状态栏中的菊花转

### 49 TouchIDTutorial

### 50 CustomFontTutorial
https://www.ioscreator.com/tutorials/custom-fonts-interface-builder-tutorial-ios8-swift

### 51 LongPressGesturesTutorial

- 步骤
    + 按钮
    + Drag a Long Press Gesture Recognizer from the Object Library on top of the Button
    + 把按钮的**gestureRecognizers**的outlet关联到**Long Press Gesture Recognizer**
    
### 52 CustomCollectionViewCellsTutorial

### 53 SendSMSTutorial
- 知识点
    + `MessageUI` `MFMessageComposeViewControllerDelegate` `MFMessageComposeViewController`

### 54 SwipeGestureTutorial

### 55 BlurEffectTutorial

### 56 SnapBehaviourTutorial

### 57 DrawingCirclesTutorial

### 58 ShakeGestureTutorial  震动

### 59 VolumeTutorial  

### 60 ScrollViewPagingTutorial

### 61 AddRowsTableViewTutorial 
https://www.ioscreator.com/tutorials/add-rows-table-view-tutorial-ios8-swift

### 62 PathsNLayers
- [参考](http://www.appcoda.com/bezier-paths-introduction/)
- https://developer.apple.com/library/content/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html
- 知识点
    + `UIBezierPath`  create vector-based paths
    + `CGContext`   `CAShapeLayer`
- goal in this tutorial is to give you practical guidelines on how to create bezier paths and how to use shape layer objects along with them

### 63 Building a Custom Content View with UITableView and MapKit
- https://www.appcoda.com/custom-content-view/
- 以 Cureo(http://curetoapp.com/) 应用的为例来展示
?? 

### 64 Firebase
1. FirebaseTutorial
    - [Introducing Firebase with Swift 3: Login and Sign Up](http://www.appcoda.com/firebase-login-signup/)
    - AdMob notifications  cloud messaging and storage
    - 步骤
        + 设计UI
        + 在Firebase中创建项目
            * 在iOS项目中添加 `GoogleService-Info.plist` 文件
            * install pod
            

### 65 Intermediate iOS 10 Programming with Swift
- appcoda 网站书籍[Intermediate iOS 10 Programming with Swift](https://www.appcoda.com/intermediate-swift-programming-book/)的学习笔记。**Intermediate**每一节是一个项目


### 66 SpriteKit Introduction
- http://www.appcoda.com/spritekit-introduction/
- SpriteKit
Scenes
Nodes
Labels
Points
Gesture recognisers
Actions
- *Game Technology*  **SpriteKit** **SceneKit** **OpenGL ES** **Metal**
- 删除 GameScene.sks and Actions.sks；清空 GameViewController.swift GameScene.swift
- Creating the View Controller
- Creating a Scene
- Adding a Node to the Scene
- Centering the Label
- Adding a Gesture Recogniser to the Scene
- Creating an SKAction
- Working with Sequence
- ?? 3

### 67 UILabelDemo
- `UILabel` API 使用
- 常用
    1. `text` 显示文本内容 
    2. `textColor` 文字颜色 
    3. `font` 字体 
    4. `shadowColor` 文字的阴影颜色 
    5. `shadowOffset` 阴影的偏差距离（width水平方向的偏差距离，整数右边；height垂直方向上的偏差距离，正数下边） 
    6. `textAlignment` 设置文字的排列方式（偏左、偏右、居中） 
    7. `numberOfLines` 允许文字最多几行（默认1，如果是0，自动换行） 
    8. `sizeToFit()` UILabel的高度自适应文本
    9. `attributedText` 富文本

### 68 Exif
- 可交换图像文件格式常被简称为Exif（Exchangeable image file format），是专门为数码相机的照片设定的，可以记录数码照片的属性信息和拍摄数据。 

### 69 UIButtonDemo
- button类型
- 
```
 UIButtonTypeCustom = 0,    
 UIButtonTypeRoundedRect,    四个角是圆弧   型的 
 UIButtonTypeDetailDisclosure, 
 UIButtonTypeInfoLight, 
 UIButtonTypeInfoDark, 
 UIButtonTypeContactAdd,
```

- button的类型在初始化后就不能修改，如果需要修改button的外形，可通过，`layer`里的方法修改

```
[Btn.layer setMasksToBounds:YES];
[Btn.layer setCornerRadius:8.0]; //设置矩圆角半径
[Btn.layer setBorderWidth:1.0];   //边框宽度
CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 });
[Btn.layer setBorderColor:colorref];//边框颜色
```

- 按钮的状态UIControlState：

    UIControlStateNormal          //正常

    UIControlStateHighlighted    //高亮            

    UIControlStateDisabled       //禁用

    UIControlStateSelected       //选中   

    UIControlStateApplication   //当应用程序标识使用时        

    UIControlStateReserved      //为框架预留的
-  三个 Edge Insets
    var contentEdgeInsets: UIEdgeInsets
    var titleEdgeInsets: UIEdgeInsets
    var imageEdgeInsets: UIEdgeInsets
    
    ```
    public struct UIEdgeInsets {

        public var top: CGFloat // specify amount to inset (positive) for each of the edges. values can be negative to 'outset'

        public var left: CGFloat

        public var bottom: CGFloat

        public var right: CGFloat

        public init()

        public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    }
    ```

    top : 为正数的时候,是往下偏移,为负数的时候往上偏移;
    left : 为正数的时候往右偏移,为负数的时候往左偏移;
    bottom : 为正数的时候往上偏移,为负数的时候往下偏移;
    right :为正数的时候往左偏移,为负数的时候往右偏移;


### 70 A Beginner’s Guide to SiriKit in Swift
- http://www.appcoda.com/sirikit-introduction/ 
- ?? 证书问题 add the siri feature to your App ID
- 目前SiriKit被限制在几个App
VoIP calling
Messaging
Payments
Photos
Workouts
Ride booking
Car commands
CarPlay (automotive vendors only)
Restaurant reservations (requires additional support from Apple)

### 71 A Beginning’s Guide to Lottie: Creating Amazing Animations in iOS Apps
https://www.lottiefiles.com
- [Lottie](https://airbnb.design/lottie/)是Airbnb为 iOS，macOS, Android, React Native开发的动画库。对于开发者只需要加载不同动画的JSON文件就可以了，非常方便。[lottie-ios](https://github.com/airbnb/lottie-ios)
- Lottie 动画文件可以从 [Lottie Files](http://www.lottiefiles.com/)网站获取
- 用CocoaPods安装Lottie Library
    + 新建一个项目**LottieDemo**，进入项目根目录下： `pod init`。生成*Podfile*文件
    + 修改*Podfile*：
    
            target 'LottieDemo' do
              # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
              use_frameworks!
              # Pods for LottieDemo
              pod 'lottie-ios'
            end

    + 安装 `pod install`

- 到[Lottie Files](http://www.lottiefiles.com/)网站下一个JSON动画文件，加入项目中
- 创建`LOTAnimationView`（也是`UIView`的子类） 
    + 加载`Lottie`库
    + 更新 `viewDidLoad()` ：
        ```
        if let animationView = LOTAnimationView(name: "like") {
            animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
            
            animationView.loopAnimation = true
            animationView.animationSpeed = 1
            
            view.addSubview(animationView)
            
            animationView.play()
        }
        ```

- 循环播放动画： 
```
animationView.loopAnimation = true
//动画播放速度，越大越快
animationView.animationSpeed = 1
```
- 远程加载JSON动画文件
    ```
    let animationView = LOTAnimationView(contentsOf: URL(string: "https://github.com/airbnb/lottie-ios/raw/master/Example/Assets/PinJump.json")!
    ```

- 为`LOTAnimationView`添加`CGAffineTransform`效果
    ```
    animationView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    UIView.animate(withDuration: 3.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
        animationView.transform = CGAffineTransform.identity
    }, completion: nil)
    ```
    + 由于`LOTAnimationView`是`UIView`的子类，所以也有`transform`属性

### 72 MapKit Tutorial(iOS 11)
- https://www.raywenderlich.com/160517/mapkit-tutorial-getting-started
- HonoluluArt


### 73 CALayerDemo

### 74 QuickLookDemo

### 






[iTunes Search API](https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/)
 
### tips
-  Mixpanel is one of the mobile analytics platform which focuses on tracking user action rather than just their page views. 
- UIViewContentMode
- CGColor UIColor
- 19 UITabBarController 的两个向上的tabBar样式怎么控制
- `Bundle` 方法总结，获得各种地址
- iOS 动画  QuartzCore
- 多进程
- 视频
- 结构
- symbol files
- segues  “present modally”






