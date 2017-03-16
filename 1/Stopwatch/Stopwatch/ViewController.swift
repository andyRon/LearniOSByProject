//
//  ViewController.swift
//  Stopwatch
//
//  Created by andyron on 2016/12/9.
//  Copyright © 2016年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startOrEndButton: UIButton!
    
    var isStart = false
    var timer = Timer()
    var counter = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timeLabel.text = String(counter)
        startOrEndButton.setTitle("启动", for: UIControlState.normal)
    }

    @IBAction func startOrEnd(_ sender: UIButton) {
        if (isStart) {
            timer.invalidate()
            isStart = false
            startOrEndButton.setTitle("启动", for: UIControlState.normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            isStart = true
            startOrEndButton.setTitle("停止", for: UIControlState.normal)
        }
    }

    @IBAction func reset(_ sender: UIButton) {
        timer.invalidate()
        isStart = false
        counter = 0.00
        timeLabel.text = String(counter)
        startOrEndButton.setTitle("启动", for: UIControlState.normal)
    }
    
    func updateTimer() {
        counter = counter + 0.01
        timeLabel.text = String(format: "%.2f", counter)
    }
}

