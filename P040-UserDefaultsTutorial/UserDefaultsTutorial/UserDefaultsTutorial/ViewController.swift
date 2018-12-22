//
//  ViewController.swift
//  UserDefaultsTutorial
//
//  Created by andyron on 2017/3/29.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if (defaults.object(forKey: "SwitchState") != nil) {
            bluetoothSwitch.isOn = defaults.bool(forKey: "SwitchState")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var bluetoothSwitch: UISwitch!
    
    @IBAction func saveSwitchState(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if bluetoothSwitch.isOn {
            defaults.set(true, forKey: "SwitchState")
        } else {
            defaults.set(false, forKey: "SwitchState")
        }
    }


}
