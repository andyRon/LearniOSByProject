//
//  ViewController.swift
//  LoveTweet
//
//  Created by Andy Ron on 2018/8/4.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tweet: Tweet?

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var genderSeg: UISegmentedControl!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var workTF: UITextField!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var straightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        birthdayPicker.maximumDate = Date()
        // 去键盘
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector.endEditing))
        
        nameTF.delegate = self
        workTF.delegate = self
    }

    @IBAction func salarySliderValueDidChange(_ sender: UISlider) {
        salaryLabel.text = "$\((Int)(sender.value))k"
    }
    
    @IBAction func tweet(_ sender: UIButton) {
        func getLabelsInfo() -> (name: String?, work: String?, salary: String?) {
            guard let name = nameTF.text,
                let work = workTF.text,
                let salary = salaryLabel.text
                else {
                    return (nil, nil, nil)
            }
            
            if name.isEmpty || work.isEmpty || salary.isEmpty {
                return (nil, nil, nil)
            }
            
            return (name, work, salary)
        }
        
        func getAge() -> Int? {
            let ageComponents = Calendar.current.dateComponents([.year], from: birthdayPicker.date, to: Date())
            return ageComponents.year
        }
        
        // get tweet info
        let labelsInfo = getLabelsInfo()
        
        if let name = labelsInfo.name, let work = labelsInfo.work, let salary = labelsInfo.salary, let age = getAge() {
            tweet = Tweet(gender: Gender(rawValue: genderSeg.selectedSegmentIndex)!, name: name, age: age, work: work, salary: salary, isStraight: straightSwitch.isOn)
        } else {
            tweet = nil
        }
        
        switch tweet {
        case .some(let tweet):
            showAlert(title: "Love Tweet",
                      message: tweet.info,
                      buttonTitle: "OK")
            
        case .none:
            showAlert(title: "Info miss or invalid",
                      message: "Please fill out correct personal info",
                      buttonTitle: "OK")
        }
    }
    
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

