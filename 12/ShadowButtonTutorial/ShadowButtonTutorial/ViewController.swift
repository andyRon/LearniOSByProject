//
//  ViewController.swift
//  ShadowButtonTutorial
//
//  Created by andyron on 2017/3/24.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        button.layer.shadowColor = UIColor.red.cgColor
        button.layer.shadowOffset = CGSize(width: 10, height: 10)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
    }


}

