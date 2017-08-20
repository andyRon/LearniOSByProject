//
//  ViewController.swift
//  gifBackgroud
//
//  Created by andyron on 2017/8/20.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath = Bundle.main.path(forResource: "BackgroundVideoDemo", ofType: "gif")
        
        let gif = NSData(contentsOfFile: filePath!)
        
        let webViewBG = UIWebView(frame: self.view.frame)
        
        webViewBG.load(gif! as Data, mimeType: "image/gif", textEncodingName: String(), baseURL: NSURL() as URL)
        
        webViewBG.isUserInteractionEnabled = false;
        
        self.view.addSubview(webViewBG)
        
        let filter = UIView()
        
        filter.frame = self.view.frame
        
        filter.backgroundColor = UIColor.black
        
        filter.alpha = 0.05
        
        self.view.addSubview(filter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

