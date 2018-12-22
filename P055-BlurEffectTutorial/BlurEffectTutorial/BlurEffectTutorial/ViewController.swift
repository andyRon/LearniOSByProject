//
//  ViewController.swift
//  BlurEffectTutorial
//
//  Created by andyron on 2017/4/15.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blurImage(_ sender: AnyObject) {
        
        var darkBlur = UIBlurEffect(style: .dark)
        
        var blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = imageView.bounds
        
        imageView.addSubview(blurView)
    }

}

