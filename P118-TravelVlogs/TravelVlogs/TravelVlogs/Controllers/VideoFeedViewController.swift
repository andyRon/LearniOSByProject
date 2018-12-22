//
//  VideoFeedViewController.swift
//  TravelVlogs
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2018/11/7.
//  Copyright © 2018 [Andy Ron](https://github.com/andyRon). All rights reserved.
//

import UIKit
import AVKit

class VideoFeedViewController: UIViewController {

    var videos: [Video] = []
    
    let VideoCellReuseIdenifier = "VideoCell"
    let tableView = UITableView()
    
    let videoPreviewLooper = VideoLooperView(clips: VideoClip.allClip())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoPreviewLooper.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        videoPreviewLooper.pause()
    }
    
    func loadViews() {
        view.backgroundColor = .white
        
        tableView.register(VideoTableViewCell.classForCoder(), forCellReuseIdentifier: VideoCellReuseIdenifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(videoPreviewLooper)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        
        videoPreviewLooper.frame = CGRect(x: view.bounds.width - 150 - 16, y: view.bounds.height - 100 - 16, width: 150, height: 100)
        videoPreviewLooper.backgroundColor = .black
    }
}

extension VideoFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellReuseIdenifier, for: indexPath) as? VideoTableViewCell else {
            return VideoTableViewCell()
        }
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let video = videos[indexPath.row]
        return VideoTableViewCell.height(for: video)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]
        
        let videoURL = video.url
        let player = AVPlayer(url: videoURL)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}

extension VideoFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
