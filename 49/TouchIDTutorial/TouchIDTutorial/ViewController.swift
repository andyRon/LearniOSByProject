//
//  ViewController.swift
//  TouchIDTutorial
//
//  Created by andyron on 2017/4/11.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authenticateWithTouchID(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            let reason = "使用 Touch ID 验证"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
                (success: Bool, error: Error!) in
                
                if success {
                    self.showAlertController(message: "Touch ID 验证成功")
                } else {
                    self.showAlertController(message: "Touch ID 验证失败")
                }
            })
        } else {
            showAlertController(message: "Touch ID 失效")
        }
    }
    
    func showAlertController(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

