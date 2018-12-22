//
//  ViewController.swift
//  YouTubeEmbed
//
//  Created by andyron<http://andyron.com> on 2018/5/26.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getVideo(videCode: "RmHqOSrkZnk")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // https://www.youtube.com/watch?v=RmHqOSrkZnk&t=0s&list=PLVeezkr1wdoIaOW3uchPglp3yjeAPBTIW&index=21
    // videCode 是URL中v后面的字符串
    func getVideo(videCode: String) {
        let url = URL(string: "https://www.youtube.com/embed/\(videCode)")
        myWebView.load(URLRequest(url: url!))
    }

}

