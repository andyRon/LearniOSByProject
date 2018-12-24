

iOS手势处理由`UIGestureRecognizer`控制，不同手势有这个类的不同子类处理，不同手势处理有不同的相关属性。

子类 | 描述 
----|------
UITapGestureRecognizer | 点击手势  
UIPanGestureRecognizer | 跟着手移动手势 
UIPinchGestureRecognizer | 缩放手势
UIRotationGestureRecognizer | 旋转手势
UISwipeGestureRecognizer | 轻扫手势
UILongPressGestureRecognizer | 长按手势
UIScreenEdgePanGestureRecognizer | 屏幕边缘滑动手势

手势处理的步骤一般：
1. 初始化手势，并添加到需要手势的View中
2. 添加手势回调方法

### UITapGestureRecognizer
属性`numberOfTapsRequired`表示点击次数，属性`numberOfTouchesRequired`表示点击手指数。
```
var isChange = false
...
let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(tap:)))
tap.numberOfTapsRequired = 2
...
imageView.addGestureRecognizer(tap)
...

@objc func tap(tap: UITapGestureRecognizer) {
    let center = imageView.center
    if isChange {
        imageView.frame.size.width /= 2
        imageView.frame.size.height /= 2
        imageView.center = center
        isChange = false
    } else {
        imageView.frame.size.width *= 2
        imageView.frame.size.height *= 2
        imageView.center = center
        isChange = true
    }
}
```

### UIPanGestureRecognizer

```
let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(pan:)))
```

```
    @objc func pan(pan: UIPanGestureRecognizer) {
        if pan.state == .began || pan.state == .changed {
            // 移动后的变化（变化值类似向量）
            let translation = pan.translation(in: imageView.superview)
            print(translation)
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y  + translation.y)
            // view移动后，把上一步的移动值变为0，否则移动值为递增
            pan.setTranslation(CGPoint.zero, in: imageView.superview)
        }
    }
```

### UIRotationGestureRecognizer

        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotation(rotation:)))

```
    @objc func rotation(rotation: UIRotationGestureRecognizer) {
        if rotation.state == .began || rotation.state == .changed {
            imageView.transform = CGAffineTransform(rotationAngle: rotation.rotation)
        }
    }
```

### UISwipeGestureRecognizer

        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.swipe(swipe:)))
        swipe.direction = .up
        swipe.numberOfTouchesRequired = 3

```
    @objc func swipe(swipe: UISwipeGestureRecognizer) {
        print("扫的方向：\(swipe.direction),扫的手指数：\(swipe.numberOfTouchesRequired)")
    }
```

### UILongPressGestureRecognizer
`numberOfTouchesRequired` 长按的指头数
`minimumPressDuratio` 长按最小时间（秒）

        let long = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.long(long:)))
        long.numberOfTouchesRequired = 2
        long.minimumPressDuration = 1

```
    @objc func long(long: UILongPressGestureRecognizer) {
        print("长按手势，长按字头数为\(long.numberOfTouchesRequired)")
    }
```

### UIScreenEdgePanGestureRecognizer

        let screenEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ViewController.screenEdage(screenEdage:)))
        screenEdge.edges = .left

```
    @objc func screenEdage(screenEdage: UIScreenEdgePanGestureRecognizer) {
        print("屏幕边缘滑动手势：\(screenEdage.edges)")
    }
```


> 详细代码： [GestureDemo](https://github.com/andyRon/LearniOSByProject/tree/master/P083-GestureDemo)