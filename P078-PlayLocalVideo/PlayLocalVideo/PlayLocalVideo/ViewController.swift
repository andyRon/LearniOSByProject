//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by andyron on 2017/8/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

struct video {
    let image: String
    let title: String
    let source: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var data = [
        
        video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
        
    ]
    
    var playViewController : AVPlayerViewController?
    var playerView : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }


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

    @IBAction func playVideo(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "KL", ofType: "mp4")
        
        playerView = AVPlayer(url: URL(fileURLWithPath: path!))
        
        playViewController = AVPlayerViewController()
        playViewController?.player = playerView
        
        present(playViewController!, animated: true, completion: {
            self.playViewController?.player?.play()
        })
        
    }

}

