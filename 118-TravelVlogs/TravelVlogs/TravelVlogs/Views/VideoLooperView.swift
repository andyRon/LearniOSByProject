//
//  VideoLooperView.swift
//  TravelVlogs
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2018/11/7.
//  Copyright © 2018 [Andy Ron](https://github.com/andyRon). All rights reserved.
//

import UIKit
import AVFoundation

/// 小的循环播放窗口
class VideoLooperView: UIView {

    let clips: [VideoClip]
    let videoPlayerView = VideoPlayerView()
    
    /// @objc告诉Swift你想要将属性暴露给KVO(OC中的概念)
    @objc private let player = AVQueuePlayer()
    private var token: NSKeyValueObservation?

    private func initializePlayer() {
        videoPlayerView.player = player
        addAllVideosToPlayer()
        
        player.volume = 0.0
        player.play()
        // 监听currentItem的变化
        token = player.observe(\.currentItem, changeHandler: { [weak self] player, _ in
            if player.items().count == 1 {
                self?.addAllVideosToPlayer()
            }
        })
    }
    
    private func addAllVideosToPlayer() {
        for video in clips {
            
            let asset = AVURLAsset(url: video.url)
            let item = AVPlayerItem(asset: asset)
            // 把视频加入播发队列中
            player.insert(item, after: player.items().last)
        }
    }
    
    init(clips: [VideoClip]) {
        self.clips = clips
        
        super.init(frame: .zero)
        
        initializePlayer()
        addGestureRecognizers()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoPlayerView.frame = bounds
        addSubview(videoPlayerView)
    }
    
    func pause() {
        player.pause()
    }
    
    func play() {
        player.play()
    }
    
    @objc func wasTapped() {
        player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    @objc func wasDoubleTapped() {
        player.rate = player.rate == 1.0 ? 2.0 : 1.0
    }
    /// 添加两个手势
    func addGestureRecognizers() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasDoubleTapped))
        doubleTap.numberOfTapsRequired = 2
        
        tap.require(toFail: doubleTap)
        
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
}
