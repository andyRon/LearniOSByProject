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