//
//  ViewController.swift
//  ScaleImagesTutorial
//
//  Created by andyron on 2017/3/29.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBOutlet weak var myImageView: UIImageView!

    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        print(sender.scale)
        // sender.scale是缩放比例
        myImageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }

}

