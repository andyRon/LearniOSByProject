//
//  ViewController.swift
//  UIStepperTutorial
//
//  Created by andyron on 2017/3/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 当为true 最大值和最小值之间相连，就是到了最小值后下个值是最大
        stepper.wraps = true
        // 长按是否连续变化
        stepper.autorepeat = false
        
        stepper.maximumValue = 10
        
        stepper.minimumValue = -12
    }


    @IBAction func stepper(_ sender: UIStepper) {
        
        valueLabel.text = Int(stepper.value).description
    }

}

