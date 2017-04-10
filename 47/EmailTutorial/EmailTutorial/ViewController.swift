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
        body.delegate = self
        
    }


    @IBAction func sendEmail(_ sender: Any) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject(subject.text!)
        picker.setMessageBody(body.text, isHTML: true)
        
        present(picker, animated: true, completion: nil)
    }

    //MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        body.text = textView.text
        
        if text == "\n" {
            textView.resignFirstResponder()
            
            return false
        }
        
        return true
    }

}

