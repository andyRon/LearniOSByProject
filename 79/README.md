Carousel Effect  
-----------

用`UICollectionView`实现照片横屏滑动


> 参考：**[30DaysofSwift](https://github.com/allenwong/30DaysofSwift)**

> 知识点： `UICollectionView` `UIVisualEffectView` `UICollectionViewDataSource`


- 新建项目Carousel Effect
- 在IB构建UI。Collection View 里的 Scroll Direction 设置成水平滚动。`UIVisualEffectView`是用来添加模糊效果的，也可以使用类似如下的代码构建：
```
  let blurEffect = UIBlurEffect(style: .dark)
  let blurEffectView = UIVisualEffectView(effect: blurEffect)
  blurEffectView.frame = view.bounds
  backgroundImageView.addSubview(blurEffectView)
```

- 创建数据类`Interest`
- 创建`UICollectionViewCell`
- 实现`UICollectionViewDataSource`的方法（有点类似UITableViewDataSource）。
```
class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var interests = Interest.createInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.dataSource = self
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let CellIdentifier = "InterestCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        cell.interest = self.interests[indexPath.item]
        
        return cell
        
    }

}
```


![](./Carousel%20Effect.gif)
