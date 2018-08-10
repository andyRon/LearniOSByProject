//
//  ViewController.swift
//  SendSMSTutorial
//
//  Created by andyron on 2017/4/12.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController,  MFMessageComposeViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMessage(_ sender: AnyObject) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "信息内容"
        messageVC.recipients = ["10086"]  // 信息接受人的号码或在通讯录中的名字，可多个；如没有发送信息失败
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: false, completion: nil)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        default:
            break;
        }
    }
    
}

