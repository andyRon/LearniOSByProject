ReusableKnob
-----------


![](https://upload-images.jianshu.io/upload_images/1678135-a0233fbf3ed94ba8.gif?imageMogr2/auto-orient/strip)

当您在APP中需要一些新功能时，自定义UI控件将会非常有用 - 特别是当它们具有通用性，可以在其他APP中重复使用时。这个自定义控制教程涵盖了Control类型的UI创建，类似于由控制旋钮启发的圆形滑块，例如在调音台上找到的控制旋钮。

![完整预览图]()
## 开始

- 创建`Knob`文件，继承`UIControl`，关联相关控件
- 

## 设计Control视图的API

自定义UI的目的就是为了以后的重复使用，因此好用的API很重要，应该能让使用者（一段时间过后的自己或者其他开发者）在不看🙈源码时就能方便使用。

- 在`Knob.swift`中的`Knob`类中添加：

```swift
var minimumValue: Float = 0

var maximumValue: Float = 1

private (set) var value: Float = 0

func setValue(_ newValue: Float, animated: Bool = false) {
  value = min(maximumValue, max(minimumValue, newValue))
}

var isContinuous = true
```





## 设置Control UI的外表
![](https://ws4.sinaimg.cn/large/006tNbRwgy1fwdp5fmmd2j30uq0lhwf4.jpg)

如图，红色指示线的图层（`CALayer`对象）转动
- 将外观部件与控件部分分开，在`Knob.swift`的末尾添加一个新的私有类`KnobRenderer`。
  其中两个`CAShapeLayer`属性表示上图中两个图层。`CAShapeLayer`是`CALayer`的特殊子类，它使用[anti-aliasing](http://en.wikipedia.org/wiki/Spatial_anti-aliasing)和一些优化的[光栅化](https://en.wikipedia.org/wiki/Rasterisation)绘制贝塞尔曲线路径。





## 在API中公开外观属性





## 动态设置空间的额Value值

renderer中没有`value`概念，它完全以角度处理。 需要在Knob中更新`setValue(_:animated:)`，以便将`value`转换为角度并将其传递给渲染器。



## 动画对控件值的更改



## 自定义触摸交互





## 参考

[How To Make a Custom Control Tutorial: A Reusable Knob](https://www.raywenderlich.com/5294-how-to-make-a-custom-control-tutorial-a-reusable-knob)


  private (set) var value: Float = 0
