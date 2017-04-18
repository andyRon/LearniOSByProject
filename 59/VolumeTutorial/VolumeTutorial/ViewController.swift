//
//  ViewController.swift
//  VolumeTutorial
//
//  Created by andyron on 2017/4/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "bell", ofType: "mp3")
        let music = URL(fileURLWithPath: path!)
        
//        try as! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: music)
        } catch let error {
            print("abc")
        }

    }

    @IBAction func playSound(_ sender: AnyObject) {
        
        audioPlayer.play()
        
        let wrapperView = UIView(frame: CGRect(x: 30, y: 200, width: 260, height: 20))
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(wrapperView)
        
        let volumeView = MPVolumeView(frame: wrapperView.bounds)
        wrapperView.addSubview(volumeView)
    }


}

