//
//  ViewController.swift
//  FadeMusicTutorial
//
//  Created by andyron on 2017/3/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let asset = NSDataAsset(name: "Passenger - Let Her Go") else {
            print("音频载入错误")
            return
        }
        
        do {
            player = try AVAudioPlayer(data: asset.data)
        } catch {
            print("error playing audio")
            return
        }
        
        player.volume = 0
        player.numberOfLoops = -1 //循环播放的次数，-1表示一直循环播放
        player.play()
    }

    @IBAction func fadeSwitchChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            player.setVolume(1, fadeDuration: 2)
        } else {
            player.setVolume(0, fadeDuration: 10)  // 音乐逐渐消失的时间为10s
        }
        
    }

}

