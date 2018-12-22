//
//  ViewController.swift
//  CALayerDemo
//
//  Created by andyron on 2017/7/16.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var box: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        box.layer.cornerRadius = 20
        
        box.layer.shadowOffset = CGSize(width: 5, height: 5)
        box.layer.shadowOpacity = 0.7
        box.layer.shadowRadius = 10
        box.layer.shadowColor = UIColor.blue.cgColor
//            UIColor(red: 44.0/255.0, green: 62.0/255, blue: 80.0/255, alpha: 1).cgColor
        
        box.layer.borderColor = UIColor.black.cgColor
        box.layer.borderWidth = 3
        
        box.layer.contents = UIImage(named: "tree.jpg")?.cgImage
        box.layer.contentsGravity = kCAGravityResize
        box.layer.masksToBounds = true
        
        box.layer.backgroundColor = UIColor.green.cgColor
        box.layer.opacity = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

