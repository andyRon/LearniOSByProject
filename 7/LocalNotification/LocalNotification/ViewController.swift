//
//  ViewController.swift
//  LocalNotification
//
//  Created by andyron on 2017/3/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: {
        (success, error) in
            if success {
                print("success")
            } else {
                print("error")
            }
        })
    }



    @IBAction func sendLocalNotification(_ sender: UIButton) {
        // UNMutableNotificationContent 对象包含有通知当中的数据。
        let content = UNMutableNotificationContent()
        content.title = "通知"
        content.subtitle = "来自andyron"
        content.body = "just test"
        
        // UNNotificationAttachment 对象包含有通知当中的媒体内容。
        let imageName = "applelogo"
        guard let imageUrl = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageUrl, options: .none)
        
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: true)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        print(12132)
    }

}

