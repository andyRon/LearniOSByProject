![](http://upload-images.jianshu.io/upload_images/1678135-a63552e89efd1228.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
> 参考 [Building a Geo Targeting iOS App in Swift](http://www.appcoda.com/geo-targeting-ios/)

用户带着iPhone进入某个区域，并在某些区域待多久在开发肯能会有很大用处。

### 初始化项目


- 创建新的项目**GeoTargeting**，使用Single View Appliction模板
- 添加一个**Map View**，大小为整个页面
- 添加相关outlet
- 实现两个协议
```
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
```
- 设置`CLLocationManager`和`MKMapView`。
```
    // 1
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 2
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 3
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        setupData()
        
    }
```
  + 1 创建一个`CLLocationManager`的实例，用于检测用户的位置变化
  + 2 设置`locationManager`一些参数，确定精确性
 

在`viewDidAppear`中核查用户授权状态
```
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    // 1
    if  authorizationStatus == .notDetermined {
        locationManager.requestAlwaysAuthorization()
    } 
    // 2
    else if authorizationStatus == .denied {
        showAlert("Location services ")
    } 
    // 3
    else if authorizationStatus == .authorizedAlways {
        locationManager.startUpdatingLocation()
    }
}
```
  + 1 如果用户授权状态是*不确定*，就检查是否是*一直*的状态。
  + 2 如果用户授权状态是*拒绝*，就用弹框显示信息给用户看。`showAlert(title:)`是弹框函数：
  ```
        func showAlert(_ title: String) {
            print(title)
            
            let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(action)
            
            present(alertController, animated: true, completion: nil)
            
        }
  ```

  + 3 如果用户授权状态是*一直*，就开始更新地理位置。

另外，还需要在`.plist`文件中添加key为`NSLocationAlwaysUsageDescription`的提示信息 *需要一直能获取你的位置* 才可以。在调用`requestAlwaysAuthorization()`时这个key是必须的。允许获取当前位置。
![](http://upload-images.jianshu.io/upload_images/1678135-92c3625f72dfcb93.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

添加函数`setupData()`
```
func setupData() {
    // 1
    if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
        
        // 2
        let title = "全季酒店"
        let coordinate = CLLocationCoordinate2DMake(31.1849700000,121.6303200000)
        let regionRadius = 300.0
        
        // 3
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude), radius: regionRadius, identifier: title)
        locationManager.startMonitoring(for: region)
        
        // 4
        let restaurantAnnotation = MKPointAnnotation()
        restaurantAnnotation.coordinate = coordinate
        restaurantAnnotation.title = title
        mapView.addAnnotation(restaurantAnnotation)
        
        // 5
        let circle = MKCircle(center: coordinate, radius: regionRadius)
        mapView.add(circle)
        
    } else {
        print("不能追踪区域")
    }
}

// 6
func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let circleRenderer = MKCircleRenderer(overlay: overlay)
    circleRenderer.strokeColor = UIColor.red
    circleRenderer.lineWidth = 1.0
    return circleRenderer
}
```
  + 1 判断是否监控区域功能是否可用。当用户*拒绝*状态，或用户不让app背景下刷新，或飞行模式时这个功能不可用
  + 2 随意构建一个位置（如全季酒店），经纬度可通过[经纬度查询](http://www.gpsspg.com/maps.htm)查询，并设置区域半径`regionRadius`，单位是米。
  + 3 初始化`CLCircularRegion`。
  + 4 添加一个注解，类似大头针形状。
  + 5 添加区域圆圈标志。
  + 6 这是`MKMapViewDelegate`的方法，用户画圆
![](http://upload-images.jianshu.io/upload_images/1678135-c48d6e259b2697d5.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



### CLRegion
`CLRegion `就是上面标定的圆形区域。下面添加两个`CLLocationManagerDelegate`的回调方法，分别在是设备的定位位置进和出标定的区域时调用。
```
    // MARK:- CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        showAlert("enter \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        showAlert("exit \(region.identifier)")
    }
```

### Xcode中的位置调试
上面设备的位置，不可能拿着手机到处跑，Xcode提高了方便的调式方式。可以建立位置文件`.GPX`:
![](http://upload-images.jianshu.io/upload_images/1678135-baa73df392488de1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

xcode也提供世界上一些常用的位置文件：
![](http://upload-images.jianshu.io/upload_images/1678135-87343ba2104c5e86.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
点击上图调试栏最后的位置标志就可以调式了。

### 复杂逻辑下的位置处理
如果位置不停变化，在监控区域停留时间比较短，或者监控区域比较多是，处理位置问题就比较复杂了。更新部分代码：
```
// 1
var monitoredRegions: Dictionary<String, NSDate> = [:]
    
func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    showAlert("enter \(region.identifier)")
    // 2
    monitoredRegions[region.identifier] = NSDate()
}

func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    showAlert("exit \(region.identifier)")
    // 3
    monitoredRegions.removeValue(forKey: region.identifier)
}
// 4
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
   updateRegions()
}
```
- 1 定义以字典用于存储用户进入监控区的时间。
- 2 记录进入时间。
- 3 删除进入时间。
- 4 用户位置变化后调用

加入函数`updateRegions()`代码：
```
func updateRegions() {
    // 1
    let regionMaxVisiting = 10.0
    var regionsToDelete: [String] = []
    
    // 2
    for regionIdentifier in monitoredRegions.keys {
        // 3
        if NSDate().timeIntervalSince(monitoredRegions[regionIdentifier]! as Date) > regionMaxVisiting {
            showAlert("谢谢访问")
            
            regionsToDelete.append(regionIdentifier)
        }
    }
    
    // 4
    for regionIdentifier in regionsToDelete {
        monitoredRegions.removeValue(forKey: regionIdentifier)
    }
}
```
- 1 加的用户到某个区域10s，就确定用户已经到访问过这个区域。`regionsToDelete`用来存储即将删除的区域的`identifier`，也就用户待过超过10s的区域。
- 2 遍历所有监控区域
- 3 `timeIntervalSince`用来计算某个时间到当前时间的差值，单位为秒。
- 4 删除用户待过超过`regionMaxVisiting`的区域。


### 代码
[GeoTargeting](https://github.com/andyRon/LearniOSByProject/tree/master/P074-GeoTargeting)
