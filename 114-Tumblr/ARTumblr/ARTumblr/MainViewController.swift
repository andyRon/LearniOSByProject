//
//  MainViewController.swift
//  ARTumblr
//
//  Created by andyron<http://andyron.com> on 2018/6/9.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

class MainViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func unwind(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
