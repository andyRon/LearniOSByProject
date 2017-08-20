//
//  BackgroundVideo.swift
//  BackgroundVideoDemo
//
//  Created by andyron on 2017/8/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

enum BackgroundVideoErrors: Error {
    case invalidVideo
}

class BackgroundVideo {
    
    var isMuted = true
    
    private var player : AVPlayer?
    private var videoURL: URL?
    private var viewController: UIViewController?
    private var hasBeenUsed: Bool = false
    
    
    
    init (on viewController: UIViewController, withVideoURL URL: String) {
        self.viewController = viewController
        
        // parse the video string to split it into name and extension
        let videoNameAndExtension:[String]? = URL.characters.split{$0 == "."}.map(String.init)
        if videoNameAndExtension!.count == 2 {
            if let videoName = videoNameAndExtension?[0] , let videoExtension = videoNameAndExtension?[1] {
                if let url = Bundle.main.url(forResource: videoName, withExtension: videoExtension) {
                    self.videoURL = url
                    // initialize our player with our fetched video url
                    self.player = AVPlayer(url: self.videoURL!)
                } else {
                    print(BackgroundVideoErrors.invalidVideo)
                }
            }
        } else {
            print("Wrong video name format")
        }
    }
    
    
    deinit{
        
        if self.hasBeenUsed {
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil)
        }
        
    }
    
    
    public func setUpBackground(){
        self.player?.actionAtItemEnd = .none
        self.player?.isMuted = isMuted
        
        //add the video to your view ..
        let loginView: UIView = self.viewController!.view//get our view controllers view
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill // preserve aspect ratio and resize to fill screen
        playerLayer.zPosition = -1 // set it's possition behined anything in our view
        playerLayer.frame = loginView.frame // set our player frame to our view's frame
        loginView.layer.addSublayer(playerLayer)
        
        
        
        // prevent video from disturbing audio services from other apps
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            
        }
        catch {
            print("failed setting AVAudioSession Category to AVAudioSessionCategoryAmbient")
        }
        
        self.player?.play() // start the video
        
        /// 向通知中心发送视频结束后再次从头播放
        NotificationCenter.default.addObserver(self, selector: #selector(self.loopVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        // 视频进入Foreground后从头播放
        NotificationCenter.default.addObserver(self, selector: #selector(self.loopVideo), name: .UIApplicationWillEnterForeground, object: nil)
        self.hasBeenUsed = true
        
    }
    
    // 循环播放视频
    @objc private func loopVideo() {
        self.player?.seek(to: kCMTimeZero)
        self.player?.play()
    }
    
}
