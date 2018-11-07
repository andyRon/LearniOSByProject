//
//  AppDelegate.swift
//  TravelVlogs
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2018/11/7.
//  Copyright © 2018 [Andy Ron](https://github.com/andyRon) . All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 让视频播放不影响音乐应用的音乐播放（播放视频时不停止音乐播放）
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient, mode: AVAudioSession.Mode.moviePlayback, options: [.mixWithOthers])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let feed = VideoFeedViewController()
        feed.videos = Video.allVideos()
        feed.title = "Travel Vlogs"
        
        let nav = UINavigationController(rootViewController: feed)
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
                                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)]
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

    

}

