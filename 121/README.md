Chirper
------




## 建立初始项目

- `Recording` `RecordingsResult`

- `ServiceResponse` `NetworkingService`

项目使用[Xeno-canto](https://www.xeno-canto.org/article/153)网站的获取不同鸟类叫声的API（不需要翻墙，但访问速度有点慢）

- `BirdSoundTableViewCell` 及其 xib文件

- 创建 `main.storyboard`

![](https://ws1.sinaimg.cn/large/006tNbRwgy1fx3tmuj2m8j31kw0yhmyp.jpg)

- `MainViewController`


## tableview不同的状态

Loading: The app is busy fetching new data.
Error: A service call or another operation has failed.
Empty: The service call has returned no data.
Populated: The app has retrieved data to display.

第一个枚举来表示上面的状态

```swift
enum State {
    case loading
    case populated([Recording])
    case empty
    case error(Error)
}
```

不同状态的示意图：
![](https://ws1.sinaimg.cn/large/006tNbRwgy1fx3xh060cmj30jg0y30vx.jpg)


## 属性观察器

通过Swift的属性观察器来做当属性变化(`didSet`是变化后，`willSet`是变化前)的操作。这样省去了属性每次变化都需要执行的重复操作。

```swift
	var state = State.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }
```



## 添加分页




![](https://ws3.sinaimg.cn/large/006tNbRwgy1fx3xxk2bl4j307t0dw752.jpg)





## 参考

[Enum-Driven TableView Development](https://www.raywenderlich.com/5542-enum-driven-tableview-development)


