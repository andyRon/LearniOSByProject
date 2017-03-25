//
//  ViewController.swift
//  OpenPDFTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func openPDF(_ sender: UIButton) {
        
        let url = Bundle.main.url(forResource: "test", withExtension: "pdf")
     print(url)
        if let url = url {
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = NSURLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            
            view.addSubview(webView)
        }
    }

}

