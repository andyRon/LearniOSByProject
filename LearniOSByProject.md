
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



### tips
-  Mixpanel is one of the mobile analytics platform which focuses on tracking user action rather than just their page views. 
- UIViewContentMode
- CGColor UIColor

### 学习来源
- http://www.appcoda.com/
- https://www.ioscreator.com




