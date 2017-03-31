//
//  ViewController.swift
//  EmailTutorial
//
//  Created by andyron on 2017/3/31.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var subject: UITextField!
    @IBOutlet var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subject.delegate = self
        
    }


    @IBAction func sendEmail(_ sender: Any) {
    }

}

