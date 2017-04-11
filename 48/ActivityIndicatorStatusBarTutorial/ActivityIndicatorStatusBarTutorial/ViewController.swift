//
//  ViewController.swift
//  ActivityIndicatorStatusBarTutorial
//
//  Created by andyron on 2017/4/11.
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

    @IBAction func startActivity(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    @IBAction func stopActivity(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

