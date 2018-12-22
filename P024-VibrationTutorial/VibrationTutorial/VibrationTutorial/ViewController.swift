//
//  ViewController.swift
//  VibrationTutorial
//
//  Created by andyron on 2017/3/26.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func startVibration(_ sender: UIButton) {
        
        for _ in 1...5 {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            sleep(1)
        }
    }

}

