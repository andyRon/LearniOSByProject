FancyButton
---------

IBDesignable和IBInspectable的使用



![FancyButton](./FancyButton.jpg)


> 参考：[appcode](http://www.appcoda.com)网站的书[《Intermediate iOS Programming with Swift》](https://www.appcoda.com/intermediate-swift-programming-book/) 的Chapter 36



### 理解IBInspectable 和 IBDesignable

简单地说，*IBInspectable* 就是允许开发者在IB的属性检查器中添加额外的选项。*IBDesignable* 能够让* IBInspectable* 添加的额外选项产生的变化在IB中实时显示。以Button的圆角为例说明。

- 正常情况下，Button的圆角需要代码：
```
button.layer.cornerRadius = 10.0
button.layer.masksToBounds = true
```
或者直接在IB的**Identity检查器**的 **user defined runtime attributes**中添加：

![](http://upload-images.jianshu.io/upload_images/1678135-eec9a86b57546508.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意到，这种修改不是实时，在IB中Button还是直角，只有运行后才是圆角。

- 以*IBInspectable*的方式。定义个继承至`UIButton`的类。
```
class RoundedCornerButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
```
然后把button的`class`属性修改成`RoundedCornerButton`:

![](http://upload-images.jianshu.io/upload_images/1678135-9fbf46e06b820758.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

发现这个button的属性检查器中多了**Corner Radius**。
> 注意： `cornerRadius`属性变成了**Corner Radius**，`RoundedCornerButton`类变成了 **Rounded Corner Button**，这是Xcode自动转变的，开发者只需要依照swift的命名规范就可以了（类名是大写开头的驼峰命名规则，属性名是小写开头的驼峰命名规则）
 
![](http://upload-images.jianshu.io/upload_images/1678135-691ee3e3500692cf.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`cornerRadius`的类型是`CGFloat`，在属性检查器中就对应数字的选择。当然不是所有类型都可以添加属性检查器中的，*IBInspectable*支持如下类型： 
```
Int
CGFloat 
Double 
String 
Bool 
CGPoint 
CGSize 
CGRect 
UIColor 
UIImage
```

如果在类`RoundedCornerButton`前添加`@IBDesignable`，那在属性检查器中自定义的属性变化就可以在IB中实时显示了。
```
@IBDesignable class RoundedCornerButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
```

![](http://upload-images.jianshu.io/upload_images/1678135-a095fd80f28d5dd5.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 创建Fancy Button
创建Fancy Button来更加深入的了解IBInspectable 和 IBDesignable
- 创建新项目**FancyButton**
- 下载[图标](https://s3-us-west-2.amazonaws.com/swift3book/socialicons.zip)，也可以随意图标，拖进asset catalog
- 新建类`FancyButton`，继承至`UIButton`
- 圆角，边宽，边的颜色。 更新`FancyButton`：
  ```
    @IBDesignable
    class FancyButton: UIButton {

        @IBInspectable var cornerRadius: CGFloat = 0.0 {
            didSet {
                layer.cornerRadius = cornerRadius
                layer.masksToBounds = cornerRadius > 0
            }
        }
        @IBInspectable var borderWidth: CGFloat = 0.0 {
            didSet {
                layer.borderWidth = borderWidth
            }
        }
        @IBInspectable var borderColor: UIColor = .black {
            didSet {
                layer.borderColor = borderColor.cgColor
            }
        }
    }
  ```

![](http://upload-images.jianshu.io/upload_images/1678135-c4891a1cadce813c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- Title 
在`FancyButton`继续添加属性：
  ```
    @IBInspectable var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    @IBInspectable var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    @IBInspectable var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    @IBInspectable var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
  ```
 
![](http://upload-images.jianshu.io/upload_images/1678135-6dcb60f912ab6db1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 通过圆角可创建圆形button
 
![](http://upload-images.jianshu.io/upload_images/1678135-d5858246b949cfad.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- Image Padding
添加图片边距的属性：
  ```
    @IBInspectable var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    @IBInspectable var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    @IBInspectable var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
  ```

![](http://upload-images.jianshu.io/upload_images/1678135-9ea89a70a12f3a93.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- 图片靠右对齐
根据下图关系，应有`imageEdgeInsets.left = self.bounds.width - imageView.bounds.width - imageRightPadding`。

![](http://upload-images.jianshu.io/upload_images/1678135-3380113f921cf75a.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  在`FancyButton`中添加如下代码：
  ```
    @IBInspectable var enableImageRightAligned: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableImageRightAligned, let imageView = imageView {
            imageEdgeInsets.left = self.bounds.width - imageView.bounds.width - imageRightPadding
        }
    }
  ```
    + `enableImageRightAligned`属性又来自动计算 `imageEdgeInsets.left`


![](http://upload-images.jianshu.io/upload_images/1678135-cd2aea0cf9da5396.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 颜色渐变
添加三个`@IBInspectable`属性，并更新`layoutSubviews`:
  ```
    @IBInspectable var enableGradientBackground: Bool = false
    @IBInspectable var gradientColor1: UIColor = UIColor.black
    @IBInspectable var gradientColor2: UIColor = UIColor.white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if enableImageRightAligned, let imageView = imageView {
            imageEdgeInsets.left = self.bounds.width - imageView.bounds.width - imageRightPadding
        }
        
        if enableGradientBackground {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
  ```

![](http://upload-images.jianshu.io/upload_images/1678135-9873aab78bcce558.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

渐变色需要运行后才能看到

![](http://upload-images.jianshu.io/upload_images/1678135-a7399597820c5e4b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

