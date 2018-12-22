![](http://upload-images.jianshu.io/upload_images/1678135-6f4fa7800dbcae0b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 参考 [A Beginner’s Guide to CALayer](http://www.appcoda.com/calayer-introduction/)

Layers是**Core Animation Framework**的一部分。**Core Animation Framework**在iOS架构的位置：
![](http://upload-images.jianshu.io/upload_images/1678135-d21f3bd827131d43.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 访问CALayer
凡是继承至`UIView`的都将有一个属性`layer`来表示`CALayer`。
`myView.layer`

### 初始化项目
- 新建**CALayerDemo**，single View Application模板
- 新建一个`UIView`和一个`UILabel`
![](http://upload-images.jianshu.io/upload_images/1678135-146e318bb733f270.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 圆角
`CALayer`的`cornerRadius`属性大小表示`UIView`圆角处圆的半径大小。类似于`box.layer.cornerRadius = 20`，就形成了圆角，数字越大圆角效果越大，当`cornerRadius`等于`box`半径时，`box`就会变成一个园。
![](http://upload-images.jianshu.io/upload_images/1678135-ba6bfcec3d19954f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 阴影效果
```
    box.layer.shadowOffset = CGSize(width: 5, height: 5)
    box.layer.shadowOpacity = 0.7
    box.layer.shadowRadius = 10
    box.layer.shadowColor = UIColor.blue.cgColor
```
- `shadowOffset`表示阴影偏移大小，也就是阴影向`box`的下放偏移5和向右方偏移5距离。
- `shadowOpacity`是阴影透明度
-  `shadowRadius`是阴影涉及的半径，并且这个半径越大，阴影的颜色深浅就会越来越小。`shadowRadius`与`shadowOffset`是共同作用的
![](http://upload-images.jianshu.io/upload_images/1678135-145b2d2ec57a8395.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 设置边的宽度和颜色
```
    box.layer.borderColor = UIColor.black.cgColor
    box.layer.borderWidth = 3
```

### 展示图片
```
  box.layer.contents = UIImage(named: "tree.jpg")?.cgImage
  box.layer.contentsGravity = kCAGravityResize
  box.layer.masksToBounds = true
```
![](http://upload-images.jianshu.io/upload_images/1678135-97e09061d17193b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- `CALayer`的`contents`属性是`open var contents: Any?`，可以设置为图片
- `contentsGravity`设置成`kCAGravityResize`，表示`contents`的内容会调整大小以适应layer。如果设置成其他值可能出现大小不适的形象，比如`kCAGravityBottomRight`，将是：

![](http://upload-images.jianshu.io/upload_images/1678135-d9d3f61649d13d99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- `masksToBounds`为true表示按照layer的边框范围显示内容；如果是false，将会是如下结果

![](http://upload-images.jianshu.io/upload_images/1678135-346f5f5c2b619cc3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 背景颜色和透明度
```
    box.layer.backgroundColor = UIColor.green.cgColor
    box.layer.opacity = 0.5
```
