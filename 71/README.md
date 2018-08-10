A Beginning’s Guide to Lottie: Creating Amazing Animations in iOS Apps


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