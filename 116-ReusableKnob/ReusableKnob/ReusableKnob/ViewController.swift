//
//  ViewController.swift
//  ReusableKnob
//
//  Created by Andy Ron on 2018/10/19.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var valueLabel: UILabel!
  @IBOutlet var valueSlider: UISlider!
  @IBOutlet var animateSwitch: UISwitch!

  @IBOutlet weak var knob: Knob!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    knob.lineWidth = 4
    knob.pointerLength = 12
    
    knob.addTarget(self, action: #selector(ViewController.handleValueChanged(_:)), for: .valueChanged)
  }
  
  @IBAction func handleValueChanged(_ sender: Any) {
    if sender is UISlider {
      knob.setValue(valueSlider.value)
    } else {
      valueSlider.value = knob.value
    }
    updateLabel()
  }
  
  @IBAction func handleRandomButtonPressed(_ sender: Any) {
    let randomValue = Float(arc4random_uniform(101)) / 100.0
    knob.setValue(randomValue, animated: animateSwitch.isOn)
    valueSlider.setValue(Float(randomValue), animated: animateSwitch.isOn)
    updateLabel()
  }
  
  func updateLabel() {
    valueLabel.text = String(format: "%.2f", knob.value)
  }
}
