//
//  ViewController.swift
//  TextFieldAlertControllerTutorial
//
//  Created by andyron on 2017/3/28.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: AnyObject) {
        
        var usernameTextField: UITextField?
        var passwordTextField: UITextField?
        
        let alertController = UIAlertController(title: "Log in", message: "Please enter your credentials", preferredStyle: .alert)
        
        let loginAction = UIAlertAction(title: "Log in", style: .default) { (action) in
            
            if let username = usernameTextField?.text {
                print(" Username = \(username)")
            } else {
                print("No Username entered")
            }
            
            if let password = passwordTextField?.text {
                print(" Password = \(password)")
            } else {
                print("No password entered")
            }
        }
        
        
        alertController.addTextField { (txtUsername) in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = "<Your username here>"
        }
        
        alertController.addTextField { (txtPassword) in
            passwordTextField = txtPassword
            passwordTextField!.isSecureTextEntry = true
            passwordTextField!.placeholder = "<Your password here>"
        }
        
        
        alertController.addAction(loginAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

}

