//
//  ViewController.swift
//  PlayMusicAVAudioPlayerTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var trackTitle: UILabel!
    @IBOutlet var playedTime: UILabel!
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trackTitle.text = "Let Her Go - Passenger"
        let path = Bundle.main.url(forResource: "Passenger - Let Her Go", withExtension: "mp3")
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: path!)

        } catch {
            print("error")
        }
    }

    @IBAction func playOrPauseMusic(_ sender: AnyObject) {
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            audioPlayer.play()
            isPlaying = true
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
        }
    }
    
    func updateTime() {
        let currentTime = Int(audioPlayer.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        
        playedTime.text = NSString(format: "%02d:%02d", minutes,seconds) as String
    }
    
    @IBAction func stopMusic(_ sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        isPlaying = false
    }

}

