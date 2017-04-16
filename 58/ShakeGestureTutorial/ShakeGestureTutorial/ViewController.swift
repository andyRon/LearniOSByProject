//
//  ViewController.swift
//  ShakeGestureTutorial
//
//  Created by andyron on 2017/4/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var shakeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            self.shakeLabel.text = "Shaken, not stirred"
        }
    }
}

