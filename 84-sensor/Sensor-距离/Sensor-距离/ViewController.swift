//
//  ViewController.swift
//  Sensor-距离
//
//  Created by andyron on 2017/8/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.sensorStateChange(notification:)), name: Notification.Name.UIDeviceProximityStateDidChange, object: nil)
        
    }

    @objc func sensorStateChange(notification: NotificationCenter) {
        if UIDevice.current.proximityState == true {
            print("接近")
        } else {
            print("远离")
        }
    }
}

