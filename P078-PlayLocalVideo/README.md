PlayLocalVideo
----------
本地视频播放


参考： **[30DaysofSwift](https://github.com/allenwong/30DaysofSwift)**

- 新建项目`PlayLocalVideo`
- 在IB中使**View Controller**Embed In > Navigation Controller**,并在**View Controller**中添加`UITableView`和`UITableViewCell`。
- 在上面的`UITableViewCell`的中添加一个`UIImageView`作为视频的预览图、一个`UIButton`作为开始播放、两个`UILabel`分别用于显示视频的名称和来源。并修改一定样式和添加一定约束
- 添加几张图片和一个视频
- 添加一个cell的类，并添加三个接口。
```
class VideoCell: UITableViewCell {

    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
```
- 添加一个`video`枚举，用来存储视频信息。
```
struct video {
    let image: String
    let title: String
    let source: String
}
```
- 使`ViewController`符合table view代理和数据的协议，并实现所需方法：
```
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VideoCell
        
        let video = data[indexPath.row]
        
        cell.previewImageView.image = UIImage(named: video.image)
        cell.nameLabel.text = video.title
        cell.sourceLabel.text = video.source
        
        return cell
        
    }
```
- 引入播放视频所需框架，并定义相关变量。
```
import AVFoundation
import AVKit

...

    var playViewController : AVPlayerViewController?
    var playerView : AVPlayer?
```

- 实现视频播放按钮方法。
```
    @IBAction func playVideo(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "KL", ofType: "mp4")
        
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        
        playViewController = AVPlayerViewController()
        playViewController?.player = playerView
        
        present(playViewController!, animated: true, completion: {
            self.playViewController?.player?.play()
        })
        
    }
```


![](./PlayLocalVideo.gif)


