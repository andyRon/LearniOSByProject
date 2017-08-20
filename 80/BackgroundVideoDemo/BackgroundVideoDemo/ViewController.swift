//
//  ViewController.swift
//  BackgroundVideoDemo
//
//  Created by andyron on 2017/8/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var backgroundPlayer : BackgroundVideo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundPlayer = BackgroundVideo(on: self, withVideoURL: "test.mp4")
        //是否打开静音
//        backgroundPlayer?.isMuted = false 
        
        backgroundPlayer?.setUpBackground()
        

    }

}

