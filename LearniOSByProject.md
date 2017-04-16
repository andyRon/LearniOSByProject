
-------

Third目录是第三方库和包的使用情况
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


- [参考](http://www.appcoda.com/bezier-paths-introduction/)
- https://developer.apple.com/library/content/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/BezierPaths/BezierPaths.html
- 知识点
    + `UIBezierPath`  create vector-based paths
    + `CGContext`   `CAShapeLayer`





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

### 学习来源
- http://www.appcoda.com/
- https://www.ioscreator.com/
- https://www.raywenderlich.com/




