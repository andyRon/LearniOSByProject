//
//  ViewController.swift
//  MoveViewKeyboardTutorial
//
//  Created by andyron on 2017/3/30.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!

    var kbHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo {
            
            if let keyboardSize = (userInfo[Notification.Name.UIKeyboardWillChangeFrame] as? NSValue)?.cgRectValue {
                kbHeight = keyboardSize.height
                self.animateTextField(up: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(up: false)
    }
    
    func animateTextField(up: Bool) {
        let movement = up ? -kbHeight : kbHeight
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
        })
        
    }
}

