//
//  ViewController.swift
//  AirdropTutorial
//
//  Created by andyron on 2017/3/28.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "dog.jpg")
    }

    @IBOutlet var imageView: UIImageView!
    
    @IBAction func shareImage(_ sender: Any) {
        
        let image = imageView.image!
        // The Activity Controller is a standard View Controller that displays services that your application can use. This services includes Airdrop, Mail, Post to Twitter, etc.
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        // 不显示的类型（在more中也没有）
        controller.excludedActivityTypes = [UIActivityType.postToFacebook, UIActivityType.postToTwitter, UIActivityType.postToWeibo, UIActivityType.print, UIActivityType.copyToPasteboard, UIActivityType.assignToContact, UIActivityType.saveToCameraRoll, UIActivityType.postToFlickr, UIActivityType.postToTencentWeibo, UIActivityType.mail]
        
        self.present(controller, animated: true, completion: nil)
    }
    
}

